import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../pages/kelas/detail_kelas_page.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../widgets/app_icon.dart';
import 'package:voltar/l10n/app_localizations.dart';

/// Halaman Detail Kelas Guru - wrapper yang mengambil data kelas dari Firestore
/// lalu meneruskan ke DetailKelasPage dengan isTeacher: true.
class GuruKelasDetailPage extends ConsumerWidget {
  const GuruKelasDetailPage({super.key, required this.kelasId});

  final String kelasId;

  void _onEditKelas(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.guruKelasComingSoon),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classStream = FirebaseFirestore.instance
        .collection('classes')
        .doc(kelasId)
        .snapshots();

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: classStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)!.guruKelasDetailTitle,
                style: AppTypography.title.copyWith(fontWeight: FontWeight.w700),
              ),
              actions: <Widget>[
                TextButton.icon(
                  onPressed: () => _onEditKelas(context),
                  icon: const AppIcon(
                    AppIconName.pencil,
                    size: 18,
                    color: AppColors.primary,
                  ),
                  label: Text(
                      AppLocalizations.of(context)!.guruKelasEdit,
                      style: AppTypography.label.copyWith(color: AppColors.primary),
                    ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
              ],
              elevation: 0,
              scrolledUnderElevation: 0,
              surfaceTintColor: Colors.transparent,
              backgroundColor: AppColors.background,
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data!.data()!;
        final String nama = data['name'] as String? ?? 'Tanpa Nama';
        final String classCode = data['classCode'] as String? ?? '-';
        final String teacherId = data['teacherId'] as String? ?? '';

        return DetailKelasPage(
          classId: kelasId,
          className: nama,
          classCode: classCode,
          teacherId: teacherId,
          isTeacher: true,
        );
      },
    );
  }
}


