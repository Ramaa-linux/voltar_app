import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/class_post.dart';
import '../../../models/submission.dart';
import '../../../services/auth_service.dart';
import '../../../services/class_post_repository.dart';
import '../../../services/submission_repository.dart'
    as submission_repo;
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/volt_button.dart';
import 'assignment_widgets.dart';

class TugasTab extends ConsumerStatefulWidget {
  final String classId;
  final String currentUserId;
  final bool isTeacher;
  final String? teacherId;

  const TugasTab({
    super.key,
    required this.classId,
    required this.currentUserId,
    required this.isTeacher,
    this.teacherId,
  });

  @override
  ConsumerState<TugasTab> createState() => _TugasTabState();
}

class _TugasTabState extends ConsumerState<TugasTab>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final ClassPostRepository _postRepo;
  late final submission_repo.SubmissionRepository _submissionRepo;
  late final AuthService _authService;
  late final TabController _tabController;
  late Future<List<ClassPost>> _postsFuture;
  Map<String, String> _authorNames = {};

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _postRepo = ClassPostRepository();
    _submissionRepo = submission_repo.SubmissionRepository();
    _authService = AuthService();
    _tabController = TabController(length: 3, vsync: this);
    _loadPosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
    setState(() {});
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
            return const TugasLoading();
          }
          if (snapshot.hasError) {
            return _buildErrorState(snapshot.error.toString());
          }
          final allPosts = snapshot.data ?? [];
          final assignments = allPosts
              .where((p) => p.isAssignment)
              .toList()
            ..sort((a, b) {
              final aOverdue = a.isOverdue;
              final bOverdue = b.isOverdue;
              if (aOverdue != bOverdue) return aOverdue ? -1 : 1;
              final aDeadline = a.deadlineDateTime ?? DateTime(9999);
              final bDeadline = b.deadlineDateTime ?? DateTime(9999);
              return aDeadline.compareTo(bDeadline);
            });

          return Column(
            children: [
              _buildFilterTabs(assignments.length),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildAllTab(assignments),
                    _buildCompletedTab(assignments),
                    _buildPendingTab(assignments),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterTabs(int totalCount) {
    return Container(
      color: AppColors.surface,
      child: TabBar(
        controller: _tabController,
        indicatorColor: AppColors.primary,
        indicatorWeight: 3,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textTertiary,
        labelStyle: AppTypography.label.copyWith(fontWeight: FontWeight.w700),
        unselectedLabelStyle: AppTypography.label,
        tabs: [
          Tab(text: 'Semua ($totalCount)'),
          Tab(text: 'Selesai'),
          Tab(text: 'Belum Selesai'),
        ],
      ),
    );
  }

  Widget _buildAllTab(List<ClassPost> assignments) {
    return AssignmentList(
      assignments: assignments,
      isTeacher: widget.isTeacher,
      currentUserId: widget.currentUserId,
      teacherId: widget.teacherId,
      submissionRepo: _submissionRepo,
      classId: widget.classId,
      showAll: true,
    );
  }

  Widget _buildCompletedTab(List<ClassPost> assignments) {
    return StreamBuilder<List<Submission>>(
      stream: _submissionRepo.streamMySubmissions(
        classId: widget.classId,
        studentId: widget.currentUserId,
      ),
      builder: (context, snapshot) {
        final completedIds = snapshot.data
                ?.map((s) => s.postId)
                .toSet() ??
            {};

        final completedAssignments = assignments
            .where((a) => completedIds.contains(a.id))
            .toList();

        if (completedAssignments.isEmpty) {
          return _buildEmptyState(
            icon: AppIconName.checkSquare,
            title: 'Belum Ada Tugas Selesai',
            message: 'Tugas yang diselesaikan akan muncul di sini.',
          );
        }

        return AssignmentList(
          assignments: completedAssignments,
          isTeacher: widget.isTeacher,
          currentUserId: widget.currentUserId,
          teacherId: widget.teacherId,
          submissionRepo: _submissionRepo,
          classId: widget.classId,
          showAll: true,
        );
      },
    );
  }

  Widget _buildPendingTab(List<ClassPost> assignments) {
    return StreamBuilder<List<Submission>>(
      stream: _submissionRepo.streamMySubmissions(
        classId: widget.classId,
        studentId: widget.currentUserId,
      ),
      builder: (context, snapshot) {
        final completedIds = snapshot.data
                ?.map((s) => s.postId)
                .toSet() ??
            {};

        final pendingAssignments = assignments
            .where((a) => !completedIds.contains(a.id))
            .toList();

        if (pendingAssignments.isEmpty) {
          return _buildEmptyState(
            icon: AppIconName.bell,
            title: 'Semua Tugas Selesai! 🎉',
            message: 'Tidak ada tugas yang tertunda.',
          );
        }

        return AssignmentList(
          assignments: pendingAssignments,
          isTeacher: widget.isTeacher,
          currentUserId: widget.currentUserId,
          teacherId: widget.teacherId,
          submissionRepo: _submissionRepo,
          classId: widget.classId,
          showAll: true,
        );
      },
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

  Widget _buildEmptyState({
    required AppIconName icon,
    required String title,
    required String message,
  }) {
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
              child: Center(
                child: AppIcon(icon, size: 40, color: AppColors.textSecondary),
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
      ),
    );
  }
}






