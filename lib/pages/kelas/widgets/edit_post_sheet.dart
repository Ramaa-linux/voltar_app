import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../models/class_post.dart';
import '../../../services/class_post_repository.dart';
import '../../../theme/app_borders.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../utils/volt_feedback.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/volt_button.dart';
import '../../../utils/localization_helper.dart';

Future<bool?> showEditPostSheet({
  required BuildContext context,
  required ClassPost post,
  required String classId,
}) {
  final titleCtrl = TextEditingController(text: post.title ?? '');
  final contentCtrl = TextEditingController(text: post.content);
  DateTime? selectedDeadline = post.deadlineDateTime;
  bool isCommentEnabled = post.isCommentEnabled;
  bool isLoading = false;
  bool hasChanges() =>
      titleCtrl.text.trim() != (post.title ?? '').trim() ||
      contentCtrl.text.trim() != post.content.trim() ||
      selectedDeadline != post.deadlineDateTime ||
      isCommentEnabled != post.isCommentEnabled;

  return showModalBottomSheet<bool>(
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
              children: <Widget>[
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
                Text(
                  post.isAssignment ? context.t('editPostEditAssignment') : context.t('editPostEditAnnouncement'),
                  style: AppTypography.title,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Ubah konten postingan. Perubahan akan disimpan ke server.',
                  style: AppTypography.bodyMuted,
                ),
                const SizedBox(height: AppSpacing.lg),
                TextField(
                  controller: titleCtrl,
                  decoration: InputDecoration(
                    labelText: context.t('editPostTitle'),
                    hintText: post.isAssignment ? context.t('editPostAssignmentTitle') : context.t('editPostTitleOptional'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.input),
                    ),
                  ),
                  style: AppTypography.body,
                  maxLength: 100,
                  enabled: !isLoading,
                ),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  controller: contentCtrl,
                  maxLines: 4,
                  minLines: 1,
                  decoration: InputDecoration(
                    labelText: 'Isi',
                    hintText: 'Tulis isi postingan di sini...',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.input),
                    ),
                  ),
                  style: AppTypography.body,
                  enabled: !isLoading,
                ),
                if (post.isAssignment) ...[
                  const SizedBox(height: AppSpacing.md),
                  InkWell(
                    onTap: isLoading
                        ? null
                        : () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDeadline ?? DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(const Duration(days: 365)),
                            );
                            if (picked != null && ctx.mounted) {
                              final pickedTime = await showTimePicker(
                                context: ctx,
                                initialTime: TimeOfDay.fromDateTime(
                                  selectedDeadline ?? DateTime.now(),
                                ),
                              );
                              if (pickedTime != null) {
                                setModalState(() {
                                  selectedDeadline = DateTime(
                                    picked.year,
                                    picked.month,
                                    picked.day,
                                    pickedTime.hour,
                                    pickedTime.minute,
                                  );
                                });
                              }
                            }
                          },
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: context.t('editPostDeadline'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadius.input),
                        ),
                      ),
                      child: Text(
                        selectedDeadline == null
                            ? context.t('editPostSelectDeadline')
                            : 'Deadline: ${selectedDeadline!.day} ${_monthName(selectedDeadline!.month)} ${selectedDeadline!.year}, ${selectedDeadline!.hour.toString().padLeft(2, '0')}:${selectedDeadline!.minute.toString().padLeft(2, '0')}',
                        style: AppTypography.body,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: <Widget>[
                    Switch(
                      value: isCommentEnabled,
                      onChanged: isLoading
                          ? null
                          : (val) => setModalState(() => isCommentEnabled = val),
                      activeThumbColor: AppColors.primary,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        context.t('editPostAllowComments'),
                        style: AppTypography.label,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: VoltButton(
                        label: context.t('editPostCancel'),
                        onPressed: isLoading ? null : () => Navigator.pop(ctx, false),
                        variant: VoltButtonVariant.secondary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: VoltButton(
                        label: isLoading ? context.t('editPostSaving') : context.t('editPostSave'),
                        onPressed: isLoading || !hasChanges()
                            ? null
                            : () async {
                                final title = titleCtrl.text.trim();
                                final content = contentCtrl.text.trim();
                                if (content.isEmpty) {
                                  showVoltSnackBar(context, context.t('editPostContentEmpty'));
                                  return;
                                }
                                setModalState(() => isLoading = true);
                                try {
                                  final repo = ClassPostRepository();
                                  await repo.updatePost(
                                    postId: post.id,
                                    classId: classId,
                                    title: title.isEmpty ? null : title,
                                    content: content,
                                    deadline:
                                        post.isAssignment && selectedDeadline != null
                                            ? Timestamp.fromDate(selectedDeadline!)
                                            : null,
                                    isCommentEnabled: isCommentEnabled,
                                  );
                                  if (ctx.mounted) {
                                    Navigator.pop(ctx, true);
                                    showVoltSnackBar(
                                      context,
                                      context.t('editPostUpdated'),
                                    );
                                  }
                                } catch (e) {
                                  setModalState(() => isLoading = false);
                                  if (ctx.mounted) {
                                    showVoltSnackBar(context, 'Gagal: $e');
                                  }
                                }
                              },
                        variant: VoltButtonVariant.primary,
                        icon: AppIconName.checkSquare,
                        fullWidth: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

String _monthName(int month) {
  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
  return months[month - 1];
}