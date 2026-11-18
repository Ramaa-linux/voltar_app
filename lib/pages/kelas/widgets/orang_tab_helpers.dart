import 'package:flutter/material.dart';
import '../../../theme/app_borders.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_icon.dart';

class MemberTile extends StatelessWidget {
  final String name;
  final String email;
  final String? role;
  final int? index;
  final bool isTeacher;

  const MemberTile({
    super.key,
    required this.name,
    required this.email,
    this.role,
    this.index,
    required this.isTeacher,
  });

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.button),
        border: Border.all(
          color: isTeacher ? AppColors.primary : AppColors.border,
          width: isTeacher ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isTeacher
                  ? AppColors.primary
                  : AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                initial,
                style: AppTypography.title.copyWith(
                  color: isTeacher ? AppColors.textOnPrimary : AppColors.primary,
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
                Text(
                  name,
                  style: AppTypography.body.copyWith(fontWeight: FontWeight.w600),
                ),
                if (email.isNotEmpty)
                  Text(email, style: AppTypography.caption),
              ],
            ),
          ),
          if (isTeacher && role != null)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(AppRadius.chip),
              ),
              child: Text(
                role!,
                style: AppTypography.caption.copyWith(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          else if (index != null)
            Text('#$index', style: AppTypography.caption),
        ],
      ),
    );
  }
}

class MemberSkeleton extends StatelessWidget {
  const MemberSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.button),
        border: AppBorders.standard,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.border,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(AppRadius.input),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Container(
                  width: 160,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(AppRadius.input),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyStudentsState extends StatelessWidget {
  final String classCode;

  const EmptyStudentsState({super.key, required this.classCode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.border.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: AppIcon(
                AppIconName.profile,
                size: 32,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text('Belum Ada Siswa', style: AppTypography.title),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Bagikan kode kelas "$classCode" kepada siswa untuk bergabung.',
            style: AppTypography.bodyMuted,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class TabEmptyState extends StatelessWidget {
  final AppIconName icon;
  final String title;
  final String message;

  const TabEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.errorLight,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: AppIcon(icon, size: 32, color: AppColors.error),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(title, style: AppTypography.title),
          const SizedBox(height: AppSpacing.xs),
          Text(
            message,
            style: AppTypography.bodyMuted,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}