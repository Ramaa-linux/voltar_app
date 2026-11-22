import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/class_post.dart';
import '../../../theme/app_borders.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../utils/volt_feedback.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/volt_card.dart';
import '../post_detail_page.dart';
import '../../../utils/localization_helper.dart';

class AssignmentCard extends ConsumerWidget {
  final ClassPost assignment;
  final String authorName;
  final bool isTeacher;
  final String currentUserId;
  final String classId;

  const AssignmentCard({
    super.key,
    required this.assignment,
    required this.authorName,
    required this.isTeacher,
    required this.currentUserId,
    required this.classId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOverdue = assignment.isOverdue;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.card),
        onTap: () async {
          final result = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailPage(
                postId: assignment.id,
                isTeacher: isTeacher,
              ),
            ),
          );
          if (result == true && context.mounted) {
            showVoltSnackBar(context, context.t('assignmentUpdated'));
          }
        },
        child: VoltCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeader(context, assignment, isOverdue),
              const SizedBox(height: AppSpacing.md),
              if (assignment.title != null && assignment.title!.isNotEmpty) ...[
                Text(
                  assignment.title!,
                  style: AppTypography.heading.copyWith(fontWeight: FontWeight.w700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              Text(
                assignment.content,
                style: AppTypography.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (assignment.deadline != null) ...[
                const SizedBox(height: AppSpacing.md),
                _buildDeadlineRow(context, assignment, isOverdue),
              ],
              const SizedBox(height: AppSpacing.md),
              Divider(height: 1, color: AppColors.border),
              const SizedBox(height: AppSpacing.sm),
              _buildFooter(context, assignment, isOverdue),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ClassPost assignment, bool isOverdue) {
    final authorDisplayName = authorName.isNotEmpty ? authorName : context.t('pengguna');
    final initial = authorDisplayName.isNotEmpty ? authorDisplayName[0].toUpperCase() : 'U';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              initial,
              style: AppTypography.title.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      authorDisplayName,
                      style: AppTypography.label.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isTeacher)
                    PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'edit') {
                          // Edit handled by parent
                        } else if (value == 'delete') {
                          _showDeleteConfirm(context, assignment);
                        }
                      },
                      itemBuilder: (context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem(value: 'edit', child: Text('Edit')),
                        const PopupMenuItem(value: 'delete', child: Text('Hapus')),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                assignment.formattedCreatedAt,
                style: AppTypography.caption.copyWith(color: AppColors.textTertiary),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildDeadlineRow(BuildContext context, ClassPost assignment, bool isOverdue) {
    return Row(
      children: <Widget>[
        AppIcon(
          AppIconName.bell,
          size: AppIconSize.md,
          color: isOverdue ? AppColors.error : AppColors.textSecondary,
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            context.t('deadlineLabel', args: [assignment.formattedDeadline]),
            style: AppTypography.body.copyWith(
              color: isOverdue ? AppColors.error : AppColors.textPrimary,
              fontWeight: isOverdue ? FontWeight.w600 : FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (isOverdue)
          Text(
            context.t('lewat'),
            style: AppTypography.caption.copyWith(color: AppColors.error, fontWeight: FontWeight.w600),
          ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, ClassPost assignment, bool isOverdue) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            isOverdue ? context.t('tugasTerlambat') : context.t('belumDikerjakan'),
            style: AppTypography.caption.copyWith(
              color: isOverdue ? AppColors.error : AppColors.textSecondary,
              fontWeight: isOverdue ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
        if (isTeacher)
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'edit') {
                // Edit handled by parent
              } else if (value == 'delete') {
                _showDeleteConfirm(context, assignment);
              }
            },
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              PopupMenuItem(value: 'edit', child: Text(context.t('edit'))),
              PopupMenuItem(value: 'delete', child: Text(context.t('delete'))),
            ],
          ),
      ],
    );
  }

  void _showDeleteConfirm(BuildContext context, ClassPost post) {
    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.t('hapusTugas')),
        content: Text(context.t('tindakanTidakDapatDibatalkan')),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.t('cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(context.t('delete')),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true && context.mounted) {
        showVoltSnackBar(context, context.t('tugasDihapus'));
        Navigator.pop(context, true);
      }
    });
  }
}
