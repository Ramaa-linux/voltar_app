import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltar/models/learning_step.dart';
import 'package:voltar/models/level_model.dart';
import 'package:voltar/repositories/materi_repository.dart';

/// Provider untuk [ProgressRepository].
final progressRepositoryProvider = Provider<ProgressRepository>((ref) {
  return const ProgressRepository();
});

/// Provider untuk memuat himpunan ID step yang telah selesai.
final completedStepsProvider = FutureProvider<Set<String>>((ref) async {
  final repo = ref.watch(progressRepositoryProvider);
  return repo.getCompletedSteps();
});

/// Provider untuk ringkasan progres belajar di halaman Home.
///
/// Menghasilkan [HomeProgressSummary] secara reaktif dan otomatis
/// diperbarui saat terjadi perubahan progres atau aktivitas streak.
final homeProgressSummaryProvider = FutureProvider<HomeProgressSummary>((
  ref,
) async {
  final repo = ref.watch(progressRepositoryProvider);
  void onProgressUpdate() {
    ref.invalidateSelf();
  }

  ProgressRepository.progressVersionNotifier.addListener(onProgressUpdate);
  ref.onDispose(() {
    ProgressRepository.progressVersionNotifier.removeListener(onProgressUpdate);
  });

  return repo.buildHomeSummary();
});

/// Ringkasan progres belajar untuk tampilan halaman Beranda (Fase 20).
@immutable
class HomeProgressSummary {
  const HomeProgressSummary({
    required this.completedCount,
    required this.totalSteps,
    required this.overallPercent,
    required this.percentLabel,
    required this.currentLevel,
    required this.nextStepId,
    required this.nextStepTitle,
    required this.nextStepLevel,
    required this.allCompleted,
    required this.streakDays,
    this.nextStepType,
    this.nextStepLevelCompleted = 0,
    this.nextStepLevelTotal = 0,
    this.coins = 240,
  });

  final int completedCount;
  final int totalSteps;
  final double overallPercent;
  final int percentLabel;
  final int currentLevel;
  final String? nextStepId;
  final String? nextStepTitle;
  final int? nextStepLevel;
  final LearningStepType? nextStepType;
  final int nextStepLevelCompleted;
  final int nextStepLevelTotal;
  final bool allCompleted;
  final int streakDays;
  final int coins;

  static const HomeProgressSummary empty = HomeProgressSummary(
    completedCount: 0,
    totalSteps: 0,
    overallPercent: 0.0,
    percentLabel: 0,
    currentLevel: 1,
    nextStepId: null,
    nextStepTitle: null,
    nextStepLevel: null,
    nextStepType: null,
    nextStepLevelCompleted: 0,
    nextStepLevelTotal: 0,
    allCompleted: false,
    streakDays: 0,
    coins: 240,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HomeProgressSummary &&
        other.completedCount == completedCount &&
        other.totalSteps == totalSteps &&
        (other.overallPercent - overallPercent).abs() < 0.0001 &&
        other.percentLabel == percentLabel &&
        other.currentLevel == currentLevel &&
        other.nextStepId == nextStepId &&
        other.nextStepTitle == nextStepTitle &&
        other.nextStepLevel == nextStepLevel &&
        other.nextStepType == nextStepType &&
        other.nextStepLevelCompleted == nextStepLevelCompleted &&
        other.nextStepLevelTotal == nextStepLevelTotal &&
        other.allCompleted == allCompleted &&
        other.streakDays == streakDays &&
        other.coins == coins;
  }

  @override
  int get hashCode => Object.hash(
    completedCount,
    totalSteps,
    overallPercent.toStringAsFixed(4),
    percentLabel,
    currentLevel,
    nextStepId,
    nextStepTitle,
    nextStepLevel,
    nextStepType,
    nextStepLevelCompleted,
    nextStepLevelTotal,
    allCompleted,
    streakDays,
    coins,
  );
}

/// Repository persistensi lokal untuk menyimpan progres belajar pengguna.
///
/// Menggunakan [SharedPreferences] dengan daftar ID step yang telah selesai.
class ProgressRepository {
  const ProgressRepository({
    this.materiRepository = const MateriRepository(),
    this.now = _defaultNow,
  });

  final MateriRepository materiRepository;
  final DateTime Function() now;

  static DateTime _defaultNow() => DateTime.now();

  static const String storageKey = 'voltar_completed_steps';
  static const String streakCountKey = 'voltar_streak_count';
  static const String streakLastDayKey = 'voltar_streak_last_day';
  static const int totalLevels = 5;
  static bool _testMockInitialized = false;

  /// Notifier perubahan progres/streak untuk memicu refresh provider.
  static final ValueNotifier<int> progressVersionNotifier = ValueNotifier<int>(
    0,
  );

  /// Rantai eksekusi untuk menserialkan operasi tulis secara aman.
  static Future<void>? _activeWrite;

  static Future<void> _enqueueWrite(Future<void> Function() task) {
    final Future<void>? prev = _activeWrite;
    final Completer<void> completer = Completer<void>();

    Future<void> run() async {
      try {
        await task();
      } finally {
        completer.complete();
      }
    }

    final Future<void> next = prev == null ? run() : prev.then((_) => run());
    _activeWrite = next;
    next.whenComplete(() {
      if (identical(_activeWrite, next)) {
        _activeWrite = null;
      }
    });
    return completer.future;
  }

  static Future<SharedPreferences> _getPrefs() {
    if (!_testMockInitialized) {
      _testMockInitialized = true;
      if (Platform.environment.containsKey('FLUTTER_TEST')) {
        // ignore: invalid_use_of_visible_for_testing_member
        SharedPreferences.setMockInitialValues(<String, Object>{});
      }
    }
    return SharedPreferences.getInstance();
  }

  /// Mengambil seluruh ID step yang telah ditandai selesai.
  Future<Set<String>> getCompletedSteps() async {
    try {
      final SharedPreferences prefs = await _getPrefs();
      final List<String> list =
          prefs.getStringList(storageKey) ?? const <String>[];
      return list.toSet();
    } on Object {
      return <String>{};
    }
  }

  /// Menandai satu step dengan [stepId] sebagai selesai.
  Future<void> markCompleted(String stepId) {
    if (stepId.isEmpty) return Future<void>.value();
    return _enqueueWrite(() async {
      try {
        final SharedPreferences prefs = await _getPrefs();
        final Set<String> current =
            (prefs.getStringList(storageKey) ?? const <String>[]).toSet();
        if (current.add(stepId)) {
          await prefs.setStringList(storageKey, current.toList());
        }
        await _recordActivityInternal(prefs, now());
        progressVersionNotifier.value++;
      } on Object {
        // Abaikan bila platform channel tidak tersedia.
      }
    });
  }

  /// Alias untuk [markCompleted].
  Future<void> markStepCompleted(String stepId) => markCompleted(stepId);

  /// Memeriksa apakah suatu level (1..5) telah selesai sepenuhnya.
  ///
  /// Mengembalikan `true` jika dan hanya jika seluruh langkah (pretest, materi,
  /// sub-materi, dan posttest) di level tersebut terdapat dalam [getCompletedSteps].
  Future<bool> isLevelCompleted(int levelNumber) async {
    if (levelNumber < 1 || levelNumber > totalLevels) return false;
    try {
      final List<LevelModel> levels = await materiRepository.getAllLevels();
      final Set<String> completed = await getCompletedSteps();
      return checkLevelCompleted(
        levelNumber: levelNumber,
        completedSteps: completed,
        levels: levels,
      );
    } on Exception {
      return false;
    }
  }

  /// Memeriksa apakah suatu level (1..5) sudah terbuka (unlocked).
  ///
  /// Aturan:
  /// - `levelNumber == 1`: selalu mengembalikan `true`.
  /// - `levelNumber >= 2`: mengembalikan `true` jika dan hanya jika seluruh
  ///   level sebelumnya (1 s.d. `levelNumber - 1`) telah selesai sepenuhnya.
  /// - `levelNumber < 1` atau `levelNumber > 5`: mengembalikan `false`.
  Future<bool> isLevelUnlocked(int levelNumber) async {
    if (levelNumber < 1 || levelNumber > totalLevels) return false;
    if (levelNumber == 1) return true;
    try {
      final List<LevelModel> levels = await materiRepository.getAllLevels();
      final Set<String> completed = await getCompletedSteps();
      return checkLevelUnlocked(
        levelNumber: levelNumber,
        completedSteps: completed,
        levels: levels,
      );
    } on Exception {
      return false;
    }
  }

  /// Evaluasi sinkron apakah [levelNumber] sudah selesai sepenuhnya.
  static bool checkLevelCompleted({
    required int levelNumber,
    required Set<String> completedSteps,
    required List<LevelModel> levels,
  }) {
    if (levelNumber < 1 || levelNumber > levels.length) return false;
    LevelModel? target;
    for (final LevelModel level in levels) {
      if (level.levelNumber == levelNumber) {
        target = level;
        break;
      }
    }
    if (target == null) return false;
    final List<String> requiredIds = target.completableStepIds;
    if (requiredIds.isEmpty) return false;
    return requiredIds.every(completedSteps.contains);
  }

  /// Evaluasi sinkron apakah [levelNumber] terbuka berdasarkan progres berantai.
  ///
  /// Berantai ketat: Level N terbuka hanya jika semua level 1..(N-1) telah tuntas.
  static bool checkLevelUnlocked({
    required int levelNumber,
    required Set<String> completedSteps,
    required List<LevelModel> levels,
  }) {
    if (levelNumber < 1) return false;
    if (levelNumber == 1) return true;
    if (levelNumber > levels.length) return false;

    for (int i = 1; i < levelNumber; i++) {
      final bool prevCompleted = checkLevelCompleted(
        levelNumber: i,
        completedSteps: completedSteps,
        levels: levels,
      );
      if (!prevCompleted) {
        return false;
      }
    }
    return true;
  }

  /// Menghapus seluruh data progres step dan streak yang tersimpan.
  Future<void> reset() {
    return _enqueueWrite(() async {
      try {
        final SharedPreferences prefs = await _getPrefs();
        await prefs.remove(storageKey);
        await prefs.remove(streakCountKey);
        await prefs.remove(streakLastDayKey);
        progressVersionNotifier.value++;
      } on Object {
        // Abaikan bila platform channel tidak tersedia.
      }
    });
  }

  // ===========================================================================
  // FASE 20 PURE HELPERS
  // ===========================================================================

  /// Format tanggal lokal menjadi string kalender ISO `yyyy-MM-dd`.
  static String formatDate(DateTime dt) {
    final String y = dt.year.toString().padLeft(4, '0');
    final String m = dt.month.toString().padLeft(2, '0');
    final String d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  /// Menghitung selisih hari kalender murni antara dua tanggal menggunakan UTC.
  static int daysBetween(DateTime a, DateTime b) {
    final DateTime aUtc = DateTime.utc(a.year, a.month, a.day);
    final DateTime bUtc = DateTime.utc(b.year, b.month, b.day);
    return bUtc.difference(aUtc).inDays;
  }

  /// Menghitung streak tampilan saat ini secara murni tanpa menulis ke prefs.
  static int computeDisplayStreak({
    required int storedCount,
    required String? lastDayStr,
    required DateTime today,
  }) {
    if (lastDayStr == null || storedCount <= 0) return 0;
    final DateTime? lastDate = DateTime.tryParse(lastDayStr);
    if (lastDate == null) return 0;

    final int diff = daysBetween(lastDate, today);
    if (diff < 0) {
      return storedCount;
    }
    if (diff == 0 || diff == 1) {
      return storedCount;
    }
    return 0;
  }

  /// Menghitung nilai streak berikutnya setelah ada aktivitas belajar hari ini.
  static ({int count, String dateStr}) computeNextStreak({
    required int storedCount,
    required String? lastDayStr,
    required DateTime today,
  }) {
    final String todayStr = formatDate(today);
    if (lastDayStr == null || storedCount <= 0) {
      return (count: 1, dateStr: todayStr);
    }
    if (lastDayStr == todayStr) {
      return (count: storedCount, dateStr: todayStr);
    }
    final DateTime? lastDate = DateTime.tryParse(lastDayStr);
    if (lastDate == null) {
      return (count: 1, dateStr: todayStr);
    }

    final int diff = daysBetween(lastDate, today);
    if (diff < 0) {
      return (count: storedCount, dateStr: lastDayStr);
    }
    if (diff == 1) {
      return (count: storedCount + 1, dateStr: todayStr);
    }
    return (count: 1, dateStr: todayStr);
  }

  /// Menghitung label persen bulat sesuai kontrak spesifikasi Fase 20.
  static int computePercentLabel({
    required int completedCount,
    required int totalSteps,
  }) {
    if (totalSteps <= 0 || completedCount <= 0) return 0;
    if (completedCount >= totalSteps) return 100;

    final int rounded = ((completedCount / totalSteps) * 100).round();
    if (rounded <= 0) return 1;
    if (rounded >= 100) return 99;
    return rounded;
  }

  /// Mencatat aktivitas belajar harian untuk pembaruan streak.
  Future<void> recordActivity({DateTime? today}) {
    final DateTime currentDay = today ?? now();
    return _enqueueWrite(() async {
      try {
        final SharedPreferences prefs = await _getPrefs();
        await _recordActivityInternal(prefs, currentDay);
        progressVersionNotifier.value++;
      } on Object {
        // Abaikan bila platform channel tidak tersedia.
      }
    });
  }

  static Future<void> _recordActivityInternal(
    SharedPreferences prefs,
    DateTime currentDay,
  ) async {
    final int storedCount = prefs.getInt(streakCountKey) ?? 0;
    final String? lastDayStr = prefs.getString(streakLastDayKey);
    final next = computeNextStreak(
      storedCount: storedCount,
      lastDayStr: lastDayStr,
      today: currentDay,
    );
    await prefs.setInt(streakCountKey, next.count);
    await prefs.setString(streakLastDayKey, next.dateStr);
  }

  /// Mengambil jumlah streak aktif saat ini.
  Future<int> getCurrentStreak({DateTime? today}) async {
    try {
      final SharedPreferences prefs = await _getPrefs();
      final int storedCount = prefs.getInt(streakCountKey) ?? 0;
      final String? lastDayStr = prefs.getString(streakLastDayKey);
      return computeDisplayStreak(
        storedCount: storedCount,
        lastDayStr: lastDayStr,
        today: today ?? now(),
      );
    } on Object {
      return 0;
    }
  }

  /// Menghitung seluruh data ringkasan progres Home dalam satu pass.
  Future<HomeProgressSummary> buildHomeSummary({DateTime? today}) async {
    try {
      final List<LevelModel> levels = await materiRepository.getAllLevels();
      final Set<String> completedRaw = await getCompletedSteps();
      final int streak = await getCurrentStreak(today: today);

      final List<
        ({String id, String title, int levelNumber, LearningStepType type})
      >
      allSteps = [];
      for (final LevelModel level in levels) {
        void collect(LearningStep step) {
          if (step.type == LearningStepType.folder) {
            final List<LearningStep> sub =
                step.subMateri ?? const <LearningStep>[];
            if (sub.isNotEmpty) {
              for (final LearningStep item in sub) {
                collect(item);
              }
            } else {
              allSteps.add((
                id: step.id,
                title: step.title,
                levelNumber: level.levelNumber,
                type: step.type,
              ));
            }
          } else {
            allSteps.add((
              id: step.id,
              title: step.title,
              levelNumber: level.levelNumber,
              type: step.type,
            ));
          }
        }

        for (final LearningStep step in level.steps) {
          collect(step);
        }
      }

      final Set<String> validIds = allSteps.map((s) => s.id).toSet();
      final Set<String> completedValid = completedRaw.intersection(validIds);

      final int totalSteps = allSteps.length;
      final int completedCount = completedValid.length;
      final double overallPercent = totalSteps == 0
          ? 0.0
          : ((completedCount / totalSteps) * 100.0).clamp(0.0, 100.0);
      final int percentLabel = computePercentLabel(
        completedCount: completedCount,
        totalSteps: totalSteps,
      );

      int currentLevel = 1;
      for (int i = levels.length; i >= 1; i--) {
        if (checkLevelUnlocked(
          levelNumber: i,
          completedSteps: completedValid,
          levels: levels,
        )) {
          currentLevel = i;
          break;
        }
      }

      String? nextStepId;
      String? nextStepTitle;
      int? nextStepLevel;
      LearningStepType? nextStepType;
      int nextStepLevelCompleted = 0;
      int nextStepLevelTotal = 0;
      bool allCompleted = false;

      if (totalSteps > 0 && completedCount == totalSteps) {
        allCompleted = true;
      } else {
        for (final s in allSteps) {
          if (!completedValid.contains(s.id)) {
            final bool isUnlocked = checkLevelUnlocked(
              levelNumber: s.levelNumber,
              completedSteps: completedValid,
              levels: levels,
            );
            if (isUnlocked) {
              nextStepId = s.id;
              nextStepTitle = s.title;
              nextStepLevel = s.levelNumber;
              nextStepType = s.type;

              // Hitung statistik untuk level dari nextStep
              final LevelModel nextLvl = levels.firstWhere(
                (lvl) => lvl.levelNumber == s.levelNumber,
              );
              final List<String> lvlStepIds = [];
              void collectLvl(LearningStep step) {
                if (step.type == LearningStepType.folder) {
                  final List<LearningStep> sub =
                      step.subMateri ?? const <LearningStep>[];
                  if (sub.isNotEmpty) {
                    for (final LearningStep item in sub) {
                      collectLvl(item);
                    }
                  } else {
                    lvlStepIds.add(step.id);
                  }
                } else {
                  lvlStepIds.add(step.id);
                }
              }

              for (final st in nextLvl.steps) {
                collectLvl(st);
              }

              nextStepLevelTotal = lvlStepIds.length;
              nextStepLevelCompleted = lvlStepIds
                  .where((id) => completedValid.contains(id))
                  .length;
              break;
            }
          }
        }
      }

      return HomeProgressSummary(
        completedCount: completedCount,
        totalSteps: totalSteps,
        overallPercent: overallPercent,
        percentLabel: percentLabel,
        currentLevel: currentLevel,
        nextStepId: nextStepId,
        nextStepTitle: nextStepTitle,
        nextStepLevel: nextStepLevel,
        nextStepType: nextStepType,
        nextStepLevelCompleted: nextStepLevelCompleted,
        nextStepLevelTotal: nextStepLevelTotal,
        allCompleted: allCompleted,
        streakDays: streak,
        coins: 240,
      );
    } on Object {
      return HomeProgressSummary.empty;
    }
  }

  /// Total seluruh langkah kurikulum.
  Future<int> getTotalSteps() async {
    final HomeProgressSummary summary = await buildHomeSummary();
    return summary.totalSteps;
  }

  /// Persentase keseluruhan dalam rentang 0..100.
  Future<double> getOverallProgress() async {
    final HomeProgressSummary summary = await buildHomeSummary();
    return summary.overallPercent;
  }

  /// Level tertinggi yang terbuka saat ini (1..5).
  Future<int> getCurrentLevel() async {
    final HomeProgressSummary summary = await buildHomeSummary();
    return summary.currentLevel;
  }

  /// ID langkah berikutnya yang belum diselesaikan dalam urutan kurikulum.
  ///
  /// Mengembalikan `null` jika seluruh materi telah selesai.
  /// Dinamai [getLastOpenedStep] sesuai kontrak spesifikasi Fase 20.
  Future<String?> getLastOpenedStep() async {
    final HomeProgressSummary summary = await buildHomeSummary();
    return summary.nextStepId;
  }
}
