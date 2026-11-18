import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/class_post.dart';
import '../../../services/auth_service.dart';
import '../../../services/class_post_repository.dart';
import '../../../services/comment_repository.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../utils/volt_feedback.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/volt_button.dart';
import 'post_card.dart';
import 'post_helpers.dart';

class ForumTab extends ConsumerStatefulWidget {
  final String classId;
  final String currentUserId;
  final bool isTeacher;
  final String? teacherId;

  const ForumTab({
    super.key,
    required this.classId,
    required this.currentUserId,
    required this.isTeacher,
    this.teacherId,
  });

  @override
  ConsumerState<ForumTab> createState() => _ForumTabState();
}

class _ForumTabState extends ConsumerState<ForumTab>
    with AutomaticKeepAliveClientMixin {
  late final ClassPostRepository _postRepo;
  late final CommentRepository _commentRepo;
  late final AuthService _authService;
  late Future<List<ClassPost>> _postsFuture;
  Map<String, String> _authorNames = {};

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _postRepo = ClassPostRepository();
    _commentRepo = CommentRepository();
    _authService = AuthService();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    _postsFuture = _postRepo.fetchPosts(widget.classId);
    final posts = await _postsFuture;
    await _resolveAuthorNames(posts);
  }

  Future<void> _resolveAuthorNames(List<ClassPost> posts) async {
    final authorIds = posts.map((p) => p.authorId).where((id) => id.isNotEmpty).toSet();
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

  Future<void> _refresh() async {
    await _loadPosts();
    setState(() {}); // Trigger rebuild with new future
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: _refresh,
      child: FutureBuilder<List<ClassPost>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pagePadding,
                AppSpacing.md,
                AppSpacing.pagePadding,
                AppSpacing.navBarClearance,
              ),
              itemCount: 3,
              itemBuilder: (_, _) => const PostSkeleton(),
            );
          }
          if (snapshot.hasError) {
            return _buildErrorState(snapshot.error.toString());
          }
          final posts = snapshot.data ?? [];
          if (posts.isEmpty) {
            return _buildEmptyState();
          }
          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.pagePadding,
              AppSpacing.md,
              AppSpacing.pagePadding,
              AppSpacing.navBarClearance,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              final authorName = _authorNames[post.authorId] ?? 'Pengguna';
              return PostCard(
                post: post,
                authorName: authorName,
                isTeacher: widget.isTeacher,
                currentUserId: widget.currentUserId,
                teacherId: widget.teacherId,
                onDelete: widget.isTeacher ? () => _deletePost(post) : null,
                onToggleComments: widget.isTeacher
                    ? () => _toggleComments(post)
                    : null,
                onAddComment: _addComment,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppIcon(AppIconName.info, size: 48, color: AppColors.error),
            const SizedBox(height: AppSpacing.md),
            Text('Gagal Memuat', style: AppTypography.title),
            const SizedBox(height: AppSpacing.xs),
            Text(
              error,
              style: AppTypography.bodyMuted,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            VoltButton(
              label: 'Coba Lagi',
              onPressed: () => setState(() {}),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.border.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: AppIcon(
                  AppIconName.bell,
                  size: 40,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text('Belum Ada Postingan', style: AppTypography.title),
            const SizedBox(height: AppSpacing.xs),
            Text(
              widget.isTeacher
                  ? 'Buat pengumuman atau tugas pertama Anda'
                  : 'Tunggu pengumuman dari guru',
              style: AppTypography.bodyMuted,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deletePost(ClassPost post) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Postingan'),
        content: Text(
          'Yakin ingin menghapus "${post.title ?? post.content.substring(0, post.content.length.clamp(0, 30))}..."?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _postRepo.deletePost(post.id);
        if (mounted) {
          showVoltSnackBar(context, 'Postingan dihapus');
        }
      } catch (e) {
        if (mounted) {
          showVoltSnackBar(context, 'Gagal menghapus: $e');
        }
      }
    }
  }

  Future<void> _toggleComments(ClassPost post) async {
    try {
      await _postRepo.toggleComments(
        postId: post.id,
        enabled: !post.isCommentEnabled,
      );
      if (mounted) {
        showVoltSnackBar(
          context,
          post.isCommentEnabled ? 'Komentar dinonaktifkan' : 'Komentar diaktifkan',
        );
      }
    } catch (e) {
      if (mounted) {
        showVoltSnackBar(context, 'Gagal mengubah status komentar: $e');
      }
    }
  }

  Future<void> _addComment(String postId, String content) async {
    try {
      await _commentRepo.addComment(
        postId: postId,
        authorId: widget.currentUserId,
        content: content,
      );
    } catch (e) {
      if (mounted) {
        showVoltSnackBar(context, 'Gagal menambah komentar: $e');
      }
    }
  }
}