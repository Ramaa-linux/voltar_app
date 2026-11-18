import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/class_post.dart';
import '../../../models/submission.dart';
import '../../../services/submission_repository.dart'
    as submission_repo;
import '../../../theme/app_borders.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../utils/volt_feedback.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/volt_button.dart';
import '../../../widgets/volt_card.dart';

class AssignmentCard extends StatelessWidget {
  final ClassPost assignment;
  final String authorName;
  final bool isTeacher;
  final String currentUserId;
  final submission_repo.SubmissionRepository submissionRepo;
  final String classId;
  final Map<String, String> studentNames;
  final Function(Iterable<String>) onResolveStudentNames;

  const AssignmentCard({
    super.key,
    required this.assignment,
    required this.authorName,
    required this.isTeacher,
    required this.currentUserId,
    required this.submissionRepo,
    required this.classId,
    required this.studentNames,
    required this.onResolveStudentNames,
  });

  @override
  Widget build(BuildContext context) {
    final isOverdue = assignment.isOverdue;
    final deadline = assignment.deadlineDateTime;

    return FutureBuilder<bool>(
      future: _isCompletedFuture(assignment.id),
      builder: (context, snapshot) {
        final isCompleted = snapshot.data ?? false;

        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: VoltCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, assignment, isOverdue, isCompleted),
                const SizedBox(height: AppSpacing.md),
                Text(assignment.content, style: AppTypography.body),
                if (deadline != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  _buildDeadlineRow(deadline, isOverdue),
                ],
                const SizedBox(height: AppSpacing.md),
                Divider(height: 1, color: AppColors.border),
                const SizedBox(height: AppSpacing.sm),
                _buildFooter(context, assignment, isCompleted, isOverdue),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> _isCompletedFuture(String postId) async {
    if (isTeacher) return false;
    return submissionRepo.isCompleted(
      postId: postId,
      studentId: currentUserId,
    );
  }

  Widget _buildHeader(
    BuildContext context,
    ClassPost assignment,
    bool isOverdue,
    bool isCompleted,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              authorName.isNotEmpty ? authorName[0].toUpperCase() : 'G',
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
            children: [
              Row(
                children: [
                  Text(
                    authorName,
                    style: AppTypography.label.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: isOverdue
                          ? AppColors.errorLight
                          : AppColors.accentLight,
                      borderRadius: BorderRadius.circular(AppRadius.chip),
                    ),
                    child: Text(
                      'TUGAS',
                      style: AppTypography.caption.copyWith(
                        color: isOverdue ? AppColors.error : AppColors.accent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                assignment.title ?? 'Tugas Tanpa Judul',
                style: AppTypography.title.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                assignment.formattedCreatedAt,
                style: AppTypography.caption,
              ),
            ],
          ),
        ),
        _buildStatusBadge(isCompleted, isOverdue),
        if (isTeacher)
          PopupMenuButton<String>(
            icon: const AppIcon(
              AppIconName.chevronDown,
              size: 20,
              color: AppColors.textSecondary,
            ),
            onSelected: (value) {
              if (value == 'view_submissions') {
                _showSubmissionsDialog(context);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'view_submissions',
                child: Row(
                  children: [
                    AppIcon(
                      AppIconName.profile,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Text('Lihat Pengumpulan'),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildStatusBadge(bool isCompleted, bool isOverdue) {
    if (isCompleted) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.successLight,
          borderRadius: BorderRadius.circular(AppRadius.chip),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppIcon(
              AppIconName.checkSquare,
              size: 14,
              color: AppColors.success,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'SELESAI',
              style: AppTypography.caption.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    }

    if (isOverdue) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.errorLight,
          borderRadius: BorderRadius.circular(AppRadius.chip),
        ),
        child: Text(
          'TERLAMBAT',
          style: AppTypography.caption.copyWith(
            color: AppColors.error,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentLight,
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
      child: Text(
        'BELUM',
        style: AppTypography.caption.copyWith(
          color: AppColors.accent,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildDeadlineRow(DateTime deadline, bool isOverdue) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isOverdue ? AppColors.errorLight : AppColors.accentLight,
        borderRadius: BorderRadius.circular(AppRadius.input),
        border: Border.all(
          color: isOverdue ? AppColors.error : AppColors.accent,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          AppIcon(
            isOverdue ? AppIconName.info : AppIconName.bell,
            size: 20,
            color: isOverdue ? AppColors.error : AppColors.accent,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Batas Waktu',
                  style: AppTypography.caption.copyWith(
                    color: isOverdue ? AppColors.error : AppColors.accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  assignment.formattedDeadline,
                  style: AppTypography.body.copyWith(
                    color: isOverdue ? AppColors.error : AppColors.textPrimary,
                    fontWeight: isOverdue ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          if (isOverdue)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(AppRadius.chip),
              ),
              child: Text(
                'TERLAMBAT',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFooter(
    BuildContext context,
    ClassPost assignment,
    bool isCompleted,
    bool isOverdue,
  ) {
    if (isTeacher) {
      return Row(
        children: [
          Expanded(
            child: FutureBuilder<List<Submission>>(
              future: submissionRepo.fetchSubmissionsForPostOnce(assignment.id),
              builder: (context, snapshot) {
                final count = snapshot.data?.length ?? 0;
                return Text(
                  '$count siswa mengumpulkan',
                  style: AppTypography.caption,
                );
              },
            ),
          ),
        ],
      );
    }

    if (isCompleted) {
      return Row(
        children: [
          Expanded(
            child: Text(
              'Tugas sudah diselesaikan',
              style: AppTypography.caption.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          VoltButton(
            label: 'Batalkan',
            onPressed: () => _toggleCompletion(false),
            variant: VoltButtonVariant.secondary,
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: Text(
            isOverdue ? 'Tugas terlambat' : 'Belum dikerjakan',
            style: AppTypography.caption.copyWith(
              color: isOverdue ? AppColors.error : AppColors.textSecondary,
              fontWeight: isOverdue ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
        VoltButton(
          label: isOverdue ? 'Kumpulkan (Terlambat)' : 'Kumpulkan',
          onPressed: () => _toggleCompletion(true),
          variant: VoltButtonVariant.primary,
          icon: AppIconName.checkSquare,
        ),
      ],
    );
  }

  Future<void> _toggleCompletion(bool complete) async {
    try {
      await submissionRepo.setCompleted(
        postId: assignment.id,
        classId: classId,
        studentId: currentUserId,
        completed: complete,
      );
    } catch (e) {
      // Handled in UI if needed
    }
  }

  void _showSubmissionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pengumpulan: ${assignment.title}'),
        content: SizedBox(
          width: double.maxFinite,
          child: FutureBuilder<List<Submission>>(
            future: submissionRepo.fetchSubmissionsForPostOnce(assignment.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final submissions = snapshot.data ?? [];
              if (submissions.isEmpty) {
                return const Text('Belum ada siswa yang mengumpulkan.');
              }

              // Collect student IDs that need name resolution
              final studentIds = submissions
                  .map((s) => s.studentId)
                  .where((id) => !studentNames.containsKey(id))
                  .toSet();

              if (studentIds.isNotEmpty) {
                // Trigger name resolution
                onResolveStudentNames(studentIds);
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: submissions.length,
                itemBuilder: (context, index) {
                  final sub = submissions[index];
                  final studentName = studentNames[sub.studentId] ?? 'Siswa';
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primaryLight,
                      child: Text(
                        studentName[0].toUpperCase(),
                        style: AppTypography.label.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    title: Text(studentName),
                    subtitle: Text(
                      'Dikumpulkan: ${sub.formattedCreatedAt}',
                    ),
                  );
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}



