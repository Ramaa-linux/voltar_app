import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/models/learning_step.dart';
import 'package:voltar/pages/materi/materi_page.dart';
import 'package:voltar/repositories/progress_repository.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/press_scale.dart';
import 'package:voltar/widgets/volt_card.dart';

/// Provider untuk memuat satu [LearningStep] kuis berdasarkan ID.
final kuisStepProvider =
    FutureProvider.family<LearningStep, String>((ref, id) async {
  final repo = ref.watch(materiRepositoryProvider);
  return repo.getStepById(id);
});

/// Halaman kuis interaktif untuk Pre-Test dan Post-Test.
class KuisPage extends ConsumerStatefulWidget {
  const KuisPage({super.key, required this.stepId});

  final String stepId;

  @override
  ConsumerState<KuisPage> createState() => _KuisPageState();
}

class _KuisPageState extends ConsumerState<KuisPage> {
  int _currentIndex = 0;
  final Map<int, int> _selectedAnswers = <int, int>{};
  bool _isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    final AsyncValue<LearningStep> stepAsync =
        ref.watch(kuisStepProvider(widget.stepId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const AppIcon.arrowLeft(
            size: AppIconSize.md,
            color: AppColors.textPrimary,
          ),
          onPressed: () => context.pop(),
        ),
        title: stepAsync.when(
          data: (step) => Text(
            step.title,
            style: AppTypography.title.copyWith(fontSize: 16),
          ),
          loading: () => const SizedBox.shrink(),
          error: (_, _) => const Text('Kuis'),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppBorders.thin),
          child: Container(color: AppColors.border, height: AppBorders.thin),
        ),
      ),
      body: stepAsync.when(
        data: (step) {
          final List<QuizQuestion> questions = step.questions ?? [];
          if (questions.isEmpty) {
            return const Center(child: Text('Tidak ada soal tersedia.'));
          }
          if (_isSubmitted) {
            return _buildResultView(step, questions);
          }
          return _buildQuizView(step, questions);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Text(
              'Gagal memuat kuis: $error',
              style: AppTypography.bodyMuted,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizView(LearningStep step, List<QuizQuestion> questions) {
    final QuizQuestion currentQuestion = questions[_currentIndex];
    final int totalQuestions = questions.length;
    final int? selectedOption = _selectedAnswers[_currentIndex];
    final bool isLast = _currentIndex == totalQuestions - 1;

    return SafeArea(
      child: Column(
        children: <Widget>[
          LinearProgressIndicator(
            value: (_currentIndex + 1) / totalQuestions,
            backgroundColor: AppColors.border,
            color: AppColors.primary,
            minHeight: 4,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.pagePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'PERTANYAAN ${_currentIndex + 1} DARI $totalQuestions',
                    style: AppTypography.overline.copyWith(
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    currentQuestion.question,
                    style: AppTypography.heading.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  for (int i = 0; i < currentQuestion.options.length; i++) ...[
                    _buildOptionTile(
                      index: i,
                      text: currentQuestion.options[i],
                      isSelected: selectedOption == i,
                      onTap: () =>
                          setState(() => _selectedAnswers[_currentIndex] = i),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                ],
              ),
            ),
          ),
          _buildBottomAction(
            step: step,
            questions: questions,
            isLast: isLast,
            hasSelection: selectedOption != null,
          ),
        ],
      ),
    );
  }
  Widget _buildOptionTile({
    required int index,
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final String label = String.fromCharCode(65 + index);
    return PressScale(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryLight : AppColors.background,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: isSelected ? AppBorders.focus : AppBorders.thin,
            ),
          ),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 14,
                backgroundColor:
                    isSelected ? AppColors.primary : AppColors.surface,
                child: Text(
                  label,
                  style: AppTypography.label.copyWith(
                    color: isSelected
                        ? AppColors.textOnPrimary
                        : AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: Text(text, style: AppTypography.body)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomAction({
    required LearningStep step,
    required List<QuizQuestion> questions,
    required bool isLast,
    required bool hasSelection,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: <Widget>[
          if (_currentIndex > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => _currentIndex--),
                child: const Text('Sebelumnya'),
              ),
            ),
          if (_currentIndex > 0) const SizedBox(width: AppSpacing.md),
          Expanded(
            flex: 2,
            child: FilledButton(
              onPressed: !hasSelection
                  ? null
                  : () {
                      if (isLast) {
                        int correct = 0;
                        for (int i = 0; i < questions.length; i++) {
                          if (_selectedAnswers[i] ==
                              questions[i].correctAnswerIndex) {
                            correct++;
                          }
                        }
                        final int score =
                            ((correct / questions.length) * 100).round();
                        final bool passed = score >= 70;
                        setState(() => _isSubmitted = true);
                        if (step.type == LearningStepType.pretest || passed) {
                          ref
                              .read(progressRepositoryProvider)
                              .markCompleted(step.id)
                              .then((_) {
                            if (mounted) {
                              ref.invalidate(completedStepsProvider);
                            }
                          });
                        }
                      } else {
                        setState(() => _currentIndex++);
                      }
                    },
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: Text(isLast ? 'Kirim Jawaban' : 'Selanjutnya'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultView(LearningStep step, List<QuizQuestion> questions) {
    int correct = 0;
    for (int i = 0; i < questions.length; i++) {
      if (_selectedAnswers[i] == questions[i].correctAnswerIndex) correct++;
    }
    final int score = ((correct / questions.length) * 100).round();
    final bool passed = score >= 70;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.pagePadding),
        child: VoltCard(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                passed ? Icons.check_circle_outline : Icons.highlight_off,
                size: 64,
                color: passed ? AppColors.success : AppColors.error,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                passed ? 'Selamat!' : 'Perlu Belajar Lagi',
                style: AppTypography.heading,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text('Skor Kamu: $score', style: AppTypography.display),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '$correct dari ${questions.length} benar',
                style: AppTypography.bodyMuted,
              ),
              const SizedBox(height: AppSpacing.xl),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => context.pop(),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  child: const Text('Kembali ke Level'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

