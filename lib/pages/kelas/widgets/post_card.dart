import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/class_post.dart';
import '../../../models/comment.dart';
import '../../../services/auth_service.dart';
import '../../../services/comment_repository.dart';
import '../../../theme/app_borders.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/volt_card.dart';
import 'post_helpers.dart';

class PostCard extends ConsumerStatefulWidget {
  final ClassPost post;
  final String authorName;
  final bool isTeacher;
  final String currentUserId;
  final String? teacherId;
  final VoidCallback? onDelete;
  final VoidCallback? onToggleComments;
  final Function(String, String) onAddComment;

  const PostCard({
    super.key,
    required this.post,
    required this.authorName,
    required this.isTeacher,
    required this.currentUserId,
    this.teacherId,
    this.onDelete,
    this.onToggleComments,
    required this.onAddComment,
  });

  @override
  ConsumerState<PostCard> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<PostCard> {
  bool _showComments = false;
  bool _commentsLoaded = false;
  int _commentCount = 0;
  final TextEditingController _commentController = TextEditingController();
  bool _isPostingComment = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final isAssignment = post.isAssignment;
    final isOverdue = post.isOverdue;
    final isAuthor = post.authorId == widget.currentUserId;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: VoltCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(post, isAssignment, isOverdue, isAuthor),
            const SizedBox(height: AppSpacing.md),
            Text(post.content, style: AppTypography.body),
            if (isAssignment && post.deadline != null) ...[
              const SizedBox(height: AppSpacing.md),
              _buildDeadlineBanner(post, isOverdue),
            ],
            const SizedBox(height: AppSpacing.md),
            Divider(height: 1, color: AppColors.border),
            const SizedBox(height: AppSpacing.sm),
            _buildFooter(post),
            if (_showComments) ...[
              const SizedBox(height: AppSpacing.md),
              _CommentsList(
                postId: post.id,
                currentUserId: widget.currentUserId,
                isTeacher: widget.isTeacher,
                onAddComment: (content) => widget.onAddComment(post.id, content),
                onCommentsLoaded: (count) {
                  if (mounted) {
                    setState(() => _commentCount = count);
                  }
                },
              ),
              const SizedBox(height: AppSpacing.md),
              if (post.isCommentEnabled)
                CommentInput(
                  controller: _commentController,
                  isPosting: _isPostingComment,
                  onSend: () async {
                    final content = _commentController.text.trim();
                    if (content.isEmpty) return;
                    setState(() => _isPostingComment = true);
                    await widget.onAddComment(post.id, content);
                    _commentController.clear();
                    setState(() => _isPostingComment = false);
                  },
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ClassPost post, bool isAssignment, bool isOverdue, bool isAuthor) {
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
              widget.authorName.isNotEmpty ? widget.authorName[0].toUpperCase() : 'G',
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
                    widget.authorName,
                    style: AppTypography.label.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  if (isAssignment) ...[
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
                    const SizedBox(width: AppSpacing.sm),
                  ] else ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                      ),
                      child: Text(
                        'PENGUMUMAN',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                ],
              ),
              if (post.title != null && post.title!.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  post.title!,
                  style: AppTypography.title.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
              Text(
                post.formattedCreatedAt,
                style: AppTypography.caption,
              ),
            ],
          ),
        ),
        if (widget.isTeacher && isAuthor) ...[
          if (post.isAssignment)
            IconButton(
              tooltip: 'Toggle komentar',
              icon: AppIcon(
                post.isCommentEnabled
                    ? AppIconName.bell
                    : AppIconName.lock,
                size: 20,
                color: AppColors.textSecondary,
              ),
              onPressed: widget.onToggleComments,
            ),
          PopupMenuButton<String>(
            icon: const AppIcon(
              AppIconName.chevronDown,
              size: 20,
              color: AppColors.textSecondary,
            ),
            onSelected: (value) {
              if (value == 'delete') widget.onDelete?.call();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    AppIcon(AppIconName.info, size: 18, color: AppColors.error),
                    SizedBox(width: AppSpacing.sm),
                    Text('Hapus', style: TextStyle(color: AppColors.error)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildDeadlineBanner(ClassPost post, bool isOverdue) {
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
                  _formatDeadline(post.deadlineDateTime!),
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

  Widget _buildFooter(ClassPost post) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Dibuat ${post.formattedCreatedAt}',
            style: AppTypography.caption,
          ),
        ),
        if (post.isCommentEnabled || widget.isTeacher)
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                _showComments = !_showComments;
                if (_showComments && !_commentsLoaded) {
                  _commentsLoaded = true;
                }
              });
            },
            icon: AppIcon(
              _showComments
                  ? AppIconName.chevronDown
                  : AppIconName.chevronRight,
              size: 16,
              color: AppColors.primary,
            ),
            label: Text(
              _commentsLoaded ? '$_commentCount Komentar' : 'Lihat Komentar',
              style: AppTypography.label,
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              minimumSize: const Size(0, 32),
              textStyle: AppTypography.label,
            ),
          ),
      ],
    );
  }

  String _formatDeadline(DateTime deadline) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final deadlineDay = DateTime(deadline.year, deadline.month, deadline.day);

    if (deadlineDay == today) {
      return 'Hari ini, ${_formatTime(deadline)}';
    } else if (deadlineDay == today.add(const Duration(days: 1))) {
      return 'Besok, ${_formatTime(deadline)}';
    } else {
      return '${_formatDate(deadline)}, ${_formatTime(deadline)}';
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

class _CommentsList extends StatefulWidget {
  final String postId;
  final String currentUserId;
  final bool isTeacher;
  final Function(String) onAddComment;
  final Function(int) onCommentsLoaded;

  const _CommentsList({
    required this.postId,
    required this.currentUserId,
    required this.isTeacher,
    required this.onAddComment,
    required this.onCommentsLoaded,
  });

  @override
  State<_CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<_CommentsList> {
  final CommentRepository _commentRepo = CommentRepository();
  late Future<List<Comment>> _commentsFuture;
  Map<String, String> _authorNames = {};
  final AuthService _authService = AuthService();
  @override
  void initState() {
    super.initState();
    _commentsFuture = _fetchCommentsOnce();
  }

  Future<List<Comment>> _fetchCommentsOnce() async {
    final comments = await _commentRepo.fetchCommentsOnce(widget.postId);
    await _resolveAuthorNames(comments);
    if (mounted) {
      widget.onCommentsLoaded(comments.length);
    }
    return comments;
  }

  Future<void> _resolveAuthorNames(List<Comment> comments) async {
    final authorIds = comments.map((c) => c.authorId).where((id) => id.isNotEmpty).toSet();
    if (authorIds.isEmpty) return;

    final usersMap = await _authService.fetchUsersByIds(authorIds);
    final Map<String, String> names = {};
    for (final entry in usersMap.entries) {
      names[entry.key] = entry.value['name'] as String? ?? 'Pengguna';
    }
    if (mounted) {
      setState(() {
        _authorNames = names;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Comment>>(
      future: _commentsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }

        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              'Gagal memuat komentar',
              style: AppTypography.bodyMuted.copyWith(color: AppColors.error),
              textAlign: TextAlign.center,
            ),
          );
        }

        final comments = snapshot.data ?? [];

        if (comments.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Text(
              'Belum ada komentar. Jadilah yang pertama!',
              style: AppTypography.bodyMuted,
              textAlign: TextAlign.center,
            ),
          );
        }

        return Column(
          children: comments.map((comment) {
            final isOwn = comment.authorId == widget.currentUserId;
            final authorName = _authorNames[comment.authorId] ?? 'Pengguna';
            return CommentTile(
              comment: comment,
              authorName: authorName,
              isOwn: isOwn,
              isTeacher: widget.isTeacher,
              currentUserId: widget.currentUserId,
            );
          }).toList(),
        );
      },
    );
  }
}





