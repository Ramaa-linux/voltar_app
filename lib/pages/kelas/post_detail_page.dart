import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/class_post.dart';
import '../../models/comment.dart';
import '../../models/submission.dart';
import '../../services/auth_service.dart';
import '../../services/class_post_repository.dart';
import '../../services/comment_repository.dart';
import '../../services/submission_repository.dart' as submission_repo;
import '../../theme/app_borders.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../utils/localization_helper.dart';
import '../../utils/volt_feedback.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/volt_button.dart';
import '../../widgets/volt_card.dart';
class PostDetailPage extends ConsumerStatefulWidget {
  final String postId;
  final bool isTeacher;
  const PostDetailPage({super.key, required this.postId, required this.isTeacher});
  @override
  ConsumerState<PostDetailPage> createState() => _PostDetailPageState();
}
class _PostDetailPageState extends ConsumerState<PostDetailPage> {
  final ClassPostRepository _postRepo = ClassPostRepository();
  final CommentRepository _commentRepo = CommentRepository();
  final submission_repo.SubmissionRepository _submissionRepo = submission_repo.SubmissionRepository();
  final AuthService _authService = AuthService();
  late Future<ClassPost?> _postFuture;
  late Future<List<Comment>> _commentsFuture;
  late Future<Submission?> _submissionFuture;
  bool _isTogglingSubmission = false;
  bool _isSendingComment = false;
  String? _currentUserId;
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  static const int _maxCommentLength = 500;
  @override
  void initState() {
    super.initState();
    _currentUserId = _authService.currentUser?.uid;
    // Pastikan widget sudah di-build dan auth siap sebelum memuat data.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _refresh();
    });
  }
  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  void _refresh() => setState(() {
    _postFuture = _fetchPost();
    _commentsFuture = _fetchComments();
    _submissionFuture = _fetchMySubmission();
  });
  Future<ClassPost?> _fetchPost() async {
    final doc = await FirebaseFirestore.instance.collection('posts').doc(widget.postId).get();
    if (!doc.exists) return null;
    return ClassPost.fromMap(doc.id, doc.data()!);
  }
  Future<List<Comment>> _fetchComments() async {
    // Tunggu status autentikasi benar-benar siap (instant, tidak ada delay manual)
    final user = await FirebaseAuth.instance.authStateChanges().first;

    debugPrint('Fetch comments postId: ${widget.postId}, userUID: ${user?.uid ?? "NULL"}');

    if (user == null) {
      // Belum login → kembalikan list kosong (UI refresh otomatis saat login via Riverpod/auth listener)
      return [];
    }

    return _commentRepo.fetchCommentsOnce(widget.postId);
  }
  Future<Submission?> _fetchMySubmission() async {
    // Tunggu status autentikasi benar-benar siap
    final user = await FirebaseAuth.instance.authStateChanges().first;

    if (user == null) return null;

    final id = Submission.createId(widget.postId, user.uid);
    final doc = await _submissionRepo.submissionsRef.doc(id).get();
    if (!doc.exists) return null;
    return Submission.fromMap(doc.id, doc.data()!);
  }

  Future<void> _sendComment() async {
    final content = _commentController.text.trim();
    if (content.isEmpty || content.length > _maxCommentLength) return;
    if (_currentUserId == null || _currentUserId!.isEmpty) return;
    setState(() => _isSendingComment = true);
    try {
      await _commentRepo.addComment(postId: widget.postId, authorId: _currentUserId!, content: content, authorName: FirebaseAuth.instance.currentUser?.displayName);
      _commentController.clear();
      if (mounted) FocusScope.of(context).unfocus();
      if (mounted) setState(() {
        _commentsFuture = _fetchComments();
      });
      _scrollToBottom();
    } catch (e) {
      if (mounted) showVoltSnackBar(context, context.t('postDetailFailedSendComment', args: [e.toString()]));
    } finally {
      if (mounted) setState(() => _isSendingComment = false);
    }
  }
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }
  Future<void> _toggleSubmission(bool complete) async {
    if (_currentUserId == null || _currentUserId!.isEmpty) return;
    setState(() => _isTogglingSubmission = true);
    try {
      await _submissionRepo.setCompleted(postId: widget.postId, classId: '', studentId: _currentUserId!, completed: complete);
      if (mounted) {
        showVoltSnackBar(context, complete ? context.t('postDetailTaskMarkedComplete') : context.t('postDetailSubmissionCancelled'));
        _refresh();
      }
    } catch (e) {
      if (mounted) showVoltSnackBar(context, context.t('postDetailFailedUpdateStatus', args: [e.toString()]));
    } finally {
      if (mounted) setState(() => _isTogglingSubmission = false);
    }
  }
  Future<void> _deletePost(ClassPost post) async {
    final confirmed = await showDialog<bool>(context: context, builder: (context) => AlertDialog(title: Text(context.t('postDetailDeleteTitle', args: [post.isAssignment ? context.t('postDetailDetailTask') : context.t('postDetailDetailAnnouncement')])), content: Text(context.t('postDetailDeleteConfirm')), actions: [TextButton(onPressed: () => Navigator.pop(context, false), child: Text(context.t('postDetailCancel'))), TextButton(onPressed: () => Navigator.pop(context, true), style: TextButton.styleFrom(foregroundColor: AppColors.error), child: Text(context.t('postDetailDelete')))]));
    if (confirmed == true) {
      try {
        await _postRepo.deletePostWithCleanup(widget.postId);
        if (mounted) { showVoltSnackBar(context, context.t('postDetailDeleted')); Navigator.pop(context, true); }
      } catch (e) {
        if (mounted) showVoltSnackBar(context, context.t('postDetailFailedDelete', args: [e.toString()]));
      }
    }
  }
  void _showEditSheet(ClassPost post) => showVoltSnackBar(context, context.t('postDetailEditComingSoon'));
  void _showStudentsCompletedDialog(ClassPost post) => showDialog(context: context, builder: (context) => _StudentsCompletedDialog(postId: widget.postId));
  Widget _buildHeader(BuildContext context, ClassPost post) {
    final authorName = post.authorName ?? context.t('postDetailUser');
    final initial = authorName.isNotEmpty ? authorName[0].toUpperCase() : 'U';
    final isEdited = post.updatedAt != null;
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 40, height: 40, decoration: BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle), child: Center(child: Text(initial, style: AppTypography.title.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)))),
      const SizedBox(width: AppSpacing.md),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Text(authorName, style: AppTypography.label.copyWith(fontWeight: FontWeight.w600, color: AppColors.textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis)),
          if (isEdited) ...[const SizedBox(width: AppSpacing.xs), Container(padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 2), decoration: BoxDecoration(color: AppColors.accentLight, borderRadius: BorderRadius.circular(AppRadius.pill)), child: Text(context.t('postDetailEdited'), style: AppTypography.caption.copyWith(color: AppColors.accent, fontWeight: FontWeight.w700, fontSize: 10)))],
        ]),
        const SizedBox(height: AppSpacing.xs),
        Text(post.formattedCreatedAt, style: AppTypography.caption.copyWith(color: AppColors.textTertiary)),
      ])),
    ]);
  }
  Widget _buildDeadlineRow(BuildContext context, ClassPost post) {
    final deadline = post.deadlineDateTime;
    final isOverdue = post.isOverdue;
    if (deadline == null) return Row(children: [const AppIcon(AppIconName.bell, size: AppIconSize.md), const SizedBox(width: AppSpacing.xs), Text(context.t('postDetailNoDeadline'), style: AppTypography.body.copyWith(color: AppColors.textSecondary))]);
    return Row(children: [AppIcon(AppIconName.bell, size: AppIconSize.md, color: isOverdue ? AppColors.error : AppColors.textSecondary), const SizedBox(width: AppSpacing.xs), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(context.t('postDetailDeadline', args: [post.formattedDeadline]), style: AppTypography.body.copyWith(color: isOverdue ? AppColors.error : AppColors.textPrimary, fontWeight: isOverdue ? FontWeight.w600 : FontWeight.w400)),
      if (isOverdue) Text(context.t('postDetailOverdue'), style: AppTypography.caption.copyWith(color: AppColors.error, fontWeight: FontWeight.w600)),
    ]))]);
  }
  Widget _buildCommentsList(List<Comment> comments) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(context.t('postDetailComments', args: [comments.length.toString()]), style: AppTypography.title.copyWith(fontWeight: FontWeight.w700)),
      const SizedBox(height: AppSpacing.md),
      if (comments.isEmpty) Padding(padding: const EdgeInsets.symmetric(vertical: AppSpacing.md), child: Center(child: Text(context.t('postDetailNoComments'), style: AppTypography.bodyMuted, textAlign: TextAlign.center)))
      else ListView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: comments.length, itemBuilder: (context, index) {
        final comment = comments[index];
        final isOwn = comment.authorId == _currentUserId;
        return _CommentTile(comment: comment, isOwn: isOwn, isTeacher: widget.isTeacher, currentUserId: _currentUserId ?? '', postId: widget.postId, onDelete: _refresh);
      }),
    ]);
  }
  Widget _buildCommentInput(bool isCommentEnabled) {
    if (!isCommentEnabled) return Container(padding: const EdgeInsets.all(AppSpacing.md), decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(AppRadius.input)), child: Row(children: [const AppIcon(AppIconName.lock, size: AppIconSize.md), const SizedBox(width: AppSpacing.sm), Expanded(child: Text(context.t('postDetailCommentsDisabled'), style: AppTypography.bodyMuted))]));
    return Row(children: [Expanded(child: TextField(controller: _commentController, maxLines: 4, minLines: 1, maxLength: _maxCommentLength, decoration: InputDecoration(hintText: context.t('postDetailCommentHint'), hintStyle: AppTypography.bodyMuted, filled: true, fillColor: AppColors.background, contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm), border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.input), borderSide: BorderSide.none), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.input), borderSide: BorderSide(color: AppColors.primary, width: 1.5)), counterText: ''), style: AppTypography.body, onSubmitted: (_) => _sendComment())), const SizedBox(width: AppSpacing.sm), VoltButton(label: context.t('postDetailSend'), onPressed: _isSendingComment ? null : _sendComment, variant: VoltButtonVariant.primary, icon: _isSendingComment ? null : AppIconName.plus)]);
  }
  Widget _buildActionButtons(BuildContext context, ClassPost post) {
    if (widget.isTeacher) return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [const SizedBox(height: AppSpacing.md), VoltButton(label: context.t('postDetailViewCompleted'), onPressed: () => _showStudentsCompletedDialog(post), variant: VoltButtonVariant.secondary, icon: AppIconName.checkSquare, fullWidth: true)]);
    return FutureBuilder<Submission?>(future: _submissionFuture, builder: (context, subSnapshot) {
      final isCompleted = subSnapshot.data != null;
      Widget completionWidget;
      if (isCompleted) {
        completionWidget = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [const AppIcon(AppIconName.checkSquare, size: AppIconSize.md, color: AppColors.success), const SizedBox(width: AppSpacing.xs), Expanded(child: Text(context.t('postDetailCompleted'), style: AppTypography.label.copyWith(color: AppColors.success, fontWeight: FontWeight.w700))), TextButton(onPressed: _isTogglingSubmission ? null : () => _toggleSubmission(false), child: Text(context.t('postDetailCancelSubmission')))]),
          if (post.isOverdue) Padding(padding: const EdgeInsets.only(top: AppSpacing.xs), child: Text(context.t('postDetailSubmittedLate'), style: AppTypography.caption.copyWith(color: AppColors.error, fontWeight: FontWeight.w600))),
        ]);
      } else {
        completionWidget = VoltButton(label: post.isOverdue ? context.t('postDetailSubmitLate') : context.t('postDetailMarkComplete'), onPressed: _isTogglingSubmission ? null : () => _toggleSubmission(true), variant: VoltButtonVariant.primary, icon: AppIconName.checkSquare, fullWidth: true);
      }
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const SizedBox(height: AppSpacing.md),
        Row(children: [Expanded(child: VoltButton(label: context.t('postDetailUploadFile'), onPressed: () => showVoltSnackBar(context, context.t('postDetailUploadComingSoon')), variant: VoltButtonVariant.secondary, icon: AppIconName.fileText))]),
        const SizedBox(height: AppSpacing.md),
        completionWidget,
      ]);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: FutureBuilder<ClassPost?>(future: _postFuture, builder: (context, snapshot) {
      final post = snapshot.data;
      final typeLabel = post?.isAssignment == true ? context.t('postDetailDetailTask') : context.t('postDetailDetailAnnouncement');
      return Text(typeLabel, style: AppTypography.title.copyWith(fontWeight: FontWeight.w700));
    }), actions: [if (widget.isTeacher) PopupMenuButton<String>(onSelected: (value) async {
      final post = await _postFuture;
      if (post == null) return;
      if (value == 'edit') { _showEditSheet(post); }
      else if (value == 'delete') { _deletePost(post); }
    }, itemBuilder: (context) => [PopupMenuItem(value: 'edit', child: Text(context.t('postDetailEditMenu'))), PopupMenuItem(value: 'delete', child: Text(context.t('postDetailDeleteMenu')))])], elevation: 0, scrolledUnderElevation: 0, surfaceTintColor: Colors.transparent, backgroundColor: AppColors.background),
      body: FutureBuilder<ClassPost?>(future: _postFuture, builder: (context, postSnapshot) {
        if (postSnapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (postSnapshot.hasError) return _buildErrorState(postSnapshot.error.toString());
        final post = postSnapshot.data;
        if (post == null) return _buildNotFoundState();
        return RefreshIndicator(onRefresh: () async => _refresh(), child: CustomScrollView(controller: _scrollController, slivers: [
          SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(AppSpacing.pagePadding, AppSpacing.md, AppSpacing.pagePadding, AppSpacing.md), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            VoltCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildHeader(context, post),
              const SizedBox(height: AppSpacing.md),
              if (post.title != null && post.title!.isNotEmpty) ...[Text(post.title!, style: AppTypography.heading.copyWith(fontWeight: FontWeight.w700)), const SizedBox(height: AppSpacing.md)],
              SelectableText(post.content, style: AppTypography.body),
              if (post.isAssignment) ...[const SizedBox(height: AppSpacing.md), _buildDeadlineRow(context, post)],
              const SizedBox(height: AppSpacing.md),
              Divider(height: 1, color: AppColors.border),
              const SizedBox(height: AppSpacing.sm),
              _buildActionButtons(context, post),
            ])),
            const SizedBox(height: AppSpacing.lg),
            FutureBuilder<List<Comment>>(future: _commentsFuture, builder: (context, commentSnapshot) {
              if (commentSnapshot.connectionState == ConnectionState.waiting) return const Padding(padding: EdgeInsets.all(AppSpacing.md), child: Center(child: CircularProgressIndicator(strokeWidth: 2)));
              if (commentSnapshot.hasError) return Padding(padding: const EdgeInsets.all(AppSpacing.md), child: Text(context.t('postDetailFailedLoadComments'), style: AppTypography.bodyMuted.copyWith(color: AppColors.error), textAlign: TextAlign.center));
              final comments = commentSnapshot.data ?? [];
              return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [const SizedBox(height: AppSpacing.md), _buildCommentsList(comments), const SizedBox(height: AppSpacing.md), _buildCommentInput(post.isCommentEnabled)]);
            }),
            const SizedBox(height: AppSpacing.navBarClearance),
          ])))
        ])
      );
    }));
  }
  Widget _buildErrorState(String error) => Center(child: Padding(padding: const EdgeInsets.all(AppSpacing.xl), child: Column(mainAxisSize: MainAxisSize.min, children: [const AppIcon(AppIconName.info, size: 48, color: AppColors.error), const SizedBox(height: AppSpacing.md), Text(context.t('postDetailFailedLoad'), style: AppTypography.title), const SizedBox(height: AppSpacing.xs), Text(error, style: AppTypography.bodyMuted, textAlign: TextAlign.center), const SizedBox(height: AppSpacing.lg), VoltButton(label: context.t('postDetailRetry'), onPressed: _refresh)])));
  Widget _buildNotFoundState() => Center(child: Padding(padding: const EdgeInsets.all(AppSpacing.xl), child: Column(mainAxisSize: MainAxisSize.min, children: [const AppIcon(AppIconName.info, size: 48, color: AppColors.textSecondary), const SizedBox(height: AppSpacing.md), Text(context.t('postDetailNotFound'), style: AppTypography.title), const SizedBox(height: AppSpacing.xs), Text(context.t('postDetailNotFoundMsg'), style: AppTypography.bodyMuted, textAlign: TextAlign.center), const SizedBox(height: AppSpacing.lg), VoltButton(label: context.t('postDetailBack'), onPressed: () => Navigator.pop(context))])));
}
class _StudentsCompletedDialog extends StatelessWidget {
  final String postId;
  const _StudentsCompletedDialog({required this.postId});
  @override
  Widget build(BuildContext context) {
    final repo = submission_repo.SubmissionRepository();
    return AlertDialog(title: Text(context.t('postDetailStudentsCompleted')), content: SizedBox(width: double.maxFinite, height: 300, child: FutureBuilder<List<Submission>>(future: repo.fetchSubmissionsForPostOnce(postId), builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
      final submissions = snapshot.data ?? [];
      if (submissions.isEmpty) return Center(child: Text(context.t('postDetailNoStudentsCompleted')));
      return ListView.builder(itemCount: submissions.length, itemBuilder: (context, index) {
        final sub = submissions[index];
        return ListTile(leading: CircleAvatar(backgroundColor: AppColors.primaryLight, child: Text(sub.studentId.isNotEmpty ? sub.studentId[0].toUpperCase() : 'S', style: AppTypography.label.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700))), title: Text(sub.studentId), subtitle: Text(context.t('postDetailCompletedAt', args: [sub.formattedCreatedAt])));
      });
    })) , actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(context.t('postDetailClose')))]);
  }
}
class _CommentTile extends StatelessWidget {
  final Comment comment;
  final bool isOwn;
  final bool isTeacher;
  final String currentUserId;
  final String postId;
  final VoidCallback onDelete;
  const _CommentTile({required this.comment, required this.isOwn, required this.isTeacher, required this.currentUserId, required this.postId, required this.onDelete});
  @override
  Widget build(BuildContext context) {
    final canDelete = isTeacher || isOwn;
    return Padding(padding: const EdgeInsets.only(bottom: AppSpacing.md), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (!isOwn) ...[
        Container(width: 40, height: 40, decoration: BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle), child: Center(child: Text('U', style: AppTypography.title.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)))),
        const SizedBox(width: AppSpacing.md),
      ] else ...[
        const SizedBox(width: 40 + AppSpacing.md),
      ],
      Expanded(child: Container(padding: const EdgeInsets.all(AppSpacing.md), decoration: BoxDecoration(color: isOwn ? AppColors.primaryLight : AppColors.background, borderRadius: BorderRadius.circular(AppRadius.button)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Expanded(child: Text(isOwn ? context.t('postDetailYou') : comment.authorName ?? comment.authorId, style: AppTypography.label.copyWith(fontWeight: FontWeight.w600))), if (canDelete) GestureDetector(onTap: () async {
          final confirmed = await showDialog<bool>(context: context, builder: (context) => AlertDialog(title: Text(context.t('postDetailDeleteComment')), content: Text(context.t('postDetailDeleteConfirm')), actions: [TextButton(onPressed: () => Navigator.pop(context, false), child: Text(context.t('postDetailCancel'))), TextButton(onPressed: () => Navigator.pop(context, true), style: TextButton.styleFrom(foregroundColor: AppColors.error), child: Text(context.t('postDetailDelete')))]));
          if (confirmed == true) {
            try {
              await CommentRepository().deleteComment(postId, comment.id);
              onDelete();
            } catch (e) {
              if (context.mounted) showVoltSnackBar(context, context.t('postDetailFailedDelete', args: [e.toString()]));
            }
          }
        }, child: const AppIcon(AppIconName.lock, size: AppIconSize.sm))]),
        const SizedBox(height: AppSpacing.xs),
        Text(comment.content, style: AppTypography.body),
        const SizedBox(height: AppSpacing.xs),
        Text(comment.formattedCreatedAt, style: AppTypography.caption),
      ]))),
    ]));
  }
}








