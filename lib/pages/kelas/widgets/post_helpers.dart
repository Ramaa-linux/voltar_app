import 'package:flutter/material.dart';
import '../../../models/comment.dart';
import '../../../theme/app_borders.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/volt_button.dart';
import '../../../widgets/volt_card.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;
  final String authorName;
  final bool isOwn;
  final bool isTeacher;
  final String currentUserId;

  const CommentTile({
    super.key,
    required this.comment,
    required this.authorName,
    required this.isOwn,
    required this.isTeacher,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final initial = authorName.isNotEmpty ? authorName[0].toUpperCase() : 'U';
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isOwn)
            const SizedBox(width: 40 + AppSpacing.md)
          else
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
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: isOwn
                    ? AppColors.primaryLight
                    : AppColors.background,
                borderRadius: BorderRadius.circular(AppRadius.button),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isOwn ? 'Anda' : authorName,
                    style: AppTypography.label.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(comment.content, style: AppTypography.body),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    comment.formattedCreatedAt,
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CommentInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isPosting;
  final VoidCallback onSend;

  const CommentInput({
    super.key,
    required this.controller,
    required this.isPosting,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Tulis komentar...',
              hintStyle: AppTypography.bodyMuted,
              filled: true,
              fillColor: AppColors.background,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.input),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.input),
                borderSide: BorderSide(color: AppColors.primary, width: 1.5),
              ),
            ),
            style: AppTypography.body,
            maxLines: 3,
            minLines: 1,
            onSubmitted: (_) => onSend(),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        VoltButton(
          label: 'Kirim',
          onPressed: isPosting ? null : onSend,
          variant: VoltButtonVariant.primary,
          icon: isPosting ? null : AppIconName.plus,
        ),
      ],
    );
  }
}

class PostSkeleton extends StatelessWidget {
  const PostSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: VoltCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: AppColors.border,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Container(
                  width: 150,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(AppRadius.input),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(AppRadius.input),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(AppRadius.input),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Divider(height: 1, color: AppColors.border),
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: 120,
              height: 14,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(AppRadius.input),
              ),
            ),
          ],
        ),
      ),
    );
  }
}