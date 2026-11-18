import 'package:flutter/material.dart';
import '../../../services/class_post_repository.dart';
import '../../../theme/app_borders.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../utils/volt_feedback.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/volt_button.dart';

/// Tampilkan bottom sheet untuk membuat Pengumuman baru.
void showCreateAnnouncementSheet({
  required BuildContext context,
  required String classId,
  required String authorId,
}) {
  final contentCtrl = TextEditingController();
  final titleCtrl = TextEditingController();
  bool isLoading = false;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.card)),
    ),
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              left: AppSpacing.pagePadding,
              right: AppSpacing.pagePadding,
              top: AppSpacing.lg,
              bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text('Buat Pengumuman', style: AppTypography.title),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Bagikan informasi penting kepada seluruh siswa di kelas.',
                  style: AppTypography.bodyMuted,
                ),
                const SizedBox(height: AppSpacing.lg),
                TextField(
                  controller: titleCtrl,
                  decoration: InputDecoration(
                    labelText: 'Judul (Opsional)',
                    hintText: 'Contoh: Jadwal Praktikum Minggu Depan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.input),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  controller: contentCtrl,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Isi Pengumuman',
                    hintText: 'Tulis pengumuman di sini...',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.input),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                VoltButton(
                  label: isLoading ? 'Memposting...' : 'Posting Pengumuman',
                  fullWidth: true,
                  onPressed: isLoading
                      ? null
                      : () async {
                          final content = contentCtrl.text.trim();
                          if (content.isEmpty) {
                            showVoltSnackBar(
                                context, 'Isi pengumuman tidak boleh kosong');
                            return;
                          }
                          setModalState(() => isLoading = true);
                          try {
                            final repo = ClassPostRepository();
                            await repo.createAnnouncement(
                              classId: classId,
                              authorId: authorId,
                              content: content,
                              title: titleCtrl.text.trim().isEmpty
                                  ? null
                                  : titleCtrl.text.trim(),
                            );
                            if (ctx.mounted) {
                              Navigator.pop(ctx);
                              showVoltSnackBar(
                                  context, 'Pengumuman berhasil diposting');
                            }
                          } catch (e) {
                            setModalState(() => isLoading = false);
                            if (ctx.mounted) {
                              showVoltSnackBar(context, 'Gagal: $e');
                            }
                          }
                        },
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

void showCreateAssignmentSheet({
  required BuildContext context,
  required String classId,
  required String authorId,
}) {
  final titleCtrl = TextEditingController();
  final contentCtrl = TextEditingController();
  DateTime? selectedDate;
  bool isLoading = false;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.card)),
    ),
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              left: AppSpacing.pagePadding,
              right: AppSpacing.pagePadding,
              top: AppSpacing.lg,
              bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text('Buat Tugas Baru', style: AppTypography.title),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Buat tugas dengan deadline untuk siswa. Deadline diset pada akhir hari (23:59).',
                  style: AppTypography.bodyMuted,
                ),
                const SizedBox(height: AppSpacing.lg),
                TextField(
                  controller: titleCtrl,
                  decoration: InputDecoration(
                    labelText: 'Judul Tugas *',
                    hintText: 'Contoh: Latihan Variabel & Tipe Data',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.input),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  controller: contentCtrl,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi Tugas',
                    hintText: 'Jelaskan detail tugas, instruksi, dll...',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.input),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                InkWell(
                  onTap: () async {
                    final now = DateTime.now();
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: now,
                      firstDate: now,
                      lastDate: now.add(const Duration(days: 365)),
                    );
                    if (picked != null) {
                      setModalState(() => selectedDate = picked);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(AppRadius.input),
                    ),
                    child: Row(
                      children: [
                        const AppIcon(
                          AppIconName.bell,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            selectedDate == null
                                ? 'Pilih Batas Waktu (Deadline)'
                                : 'Deadline: ${_formatDate(selectedDate!)} 23:59',
                            style: AppTypography.body.copyWith(
                              color: selectedDate == null
                                  ? AppColors.textSecondary
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                        if (selectedDate != null)
                          IconButton(
                            icon: const AppIcon(
                              AppIconName.chevronDown,
                              size: 20,
                              color: AppColors.textSecondary,
                            ),
                            onPressed: () =>
                                setModalState(() => selectedDate = null),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                VoltButton(
                  label: isLoading ? 'Membuat...' : 'Buat Tugas',
                  fullWidth: true,
                  variant: VoltButtonVariant.primary,
                  icon: AppIconName.checkSquare,
                  onPressed: isLoading
                      ? null
                      : () async {
                          final title = titleCtrl.text.trim();
                          final content = contentCtrl.text.trim();
                          if (title.isEmpty) {
                            showVoltSnackBar(context, 'Judul tugas wajib diisi');
                            return;
                          }
                          if (content.isEmpty) {
                            showVoltSnackBar(context, 'Deskripsi tugas wajib diisi');
                            return;
                          }
                          if (selectedDate == null) {
                            showVoltSnackBar(context, 'Deadline wajib dipilih');
                            return;
                          }
                          setModalState(() => isLoading = true);
                          try {
                            final repo = ClassPostRepository();
                            await repo.createAssignment(
                              classId: classId,
                              authorId: authorId,
                              title: title,
                              content: content,
                              deadline: selectedDate!,
                            );
                            if (ctx.mounted) {
                              Navigator.pop(ctx);
                              showVoltSnackBar(context, 'Tugas berhasil dibuat');
                            }
                          } catch (e) {
                            setModalState(() => isLoading = false);
                            if (ctx.mounted) {
                              showVoltSnackBar(context, 'Gagal: $e');
                            }
                          }
                        },
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

String _formatDate(DateTime date) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
  ];
  return '${date.day} ${months[date.month - 1]} ${date.year}';
}