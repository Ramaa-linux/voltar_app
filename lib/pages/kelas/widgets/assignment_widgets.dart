import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/class_post.dart';
import '../../../services/auth_service.dart';
import '../../../services/submission_repository.dart'
    as submission_repo;
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/volt_card.dart';
import 'assignment_card.dart';
import '../../../utils/localization_helper.dart';

class TugasLoading extends StatelessWidget {
  const TugasLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.surface,
          child: TabBar(
            indicatorColor: AppColors.primary,
            indicatorWeight: 3,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textTertiary,
            labelStyle: AppTypography.label.copyWith(fontWeight: FontWeight.w700),
            unselectedLabelStyle: AppTypography.label,
            tabs: [
              Tab(text: context.t('semuaTab')),
              Tab(text: context.t('selesaiTugas')),
              Tab(text: context.t('belumDikerjakan')),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.pagePadding,
              AppSpacing.md,
              AppSpacing.pagePadding,
              AppSpacing.navBarClearance,
            ),
            itemCount: 3,
            itemBuilder: (_, _) => const AssignmentSkeleton(),
          ),
        ),
      ],
    );
  }
}

class AssignmentSkeleton extends StatelessWidget {
  const AssignmentSkeleton({super.key});

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
                  width: 180,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Container(
                  width: 60,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Divider(height: 1, color: AppColors.border),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Container(
                  width: 120,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 80,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AssignmentList extends ConsumerStatefulWidget {
  final List<ClassPost> assignments;
  final bool isTeacher;
  final String currentUserId;
  final String? teacherId;
  final submission_repo.SubmissionRepository submissionRepo;
  final String classId;
  final bool showAll;
  final Map<String, String> authorNames;

  const AssignmentList({
    super.key,
    required this.assignments,
    required this.isTeacher,
    required this.currentUserId,
    this.teacherId,
    required this.submissionRepo,
    required this.classId,
    this.showAll = true,
    this.authorNames = const {},
  });

  @override
  ConsumerState<AssignmentList> createState() => _AssignmentListState();
}

class _AssignmentListState extends ConsumerState<AssignmentList> {
  late final AuthService _authService;
  final Map<String, String> _studentNames = {};

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
  }

  Future<void> _resolveStudentNames(Iterable<String> studentIds) async {
    if (studentIds.isEmpty) return;
    final usersMap = await _authService.fetchUsersByIds(studentIds);
    final Map<String, String> names = {};
    for (final entry in usersMap.entries) {
      names[entry.key] = entry.value['name'] as String? ?? context.t('siswa');
    }
    if (mounted) {
      setState(() {
        _studentNames.addAll(names);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.assignments.isEmpty) {
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
                    AppIconName.fileText,
                    size: 40,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(context.t('belumAdaTugas'), style: AppTypography.title),
              const SizedBox(height: AppSpacing.xs),
              Text(
                widget.isTeacher
                    ? context.t('buatTugasBaru')
                    : context.t('tungguTugasDariGuru'),
                style: AppTypography.bodyMuted,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pagePadding,
        AppSpacing.md,
        AppSpacing.pagePadding,
        AppSpacing.navBarClearance,
      ),
      itemCount: widget.assignments.length,
      itemBuilder: (context, index) {
        final assignment = widget.assignments[index];
        final authorName = widget.authorNames[assignment.authorId] ?? context.t('guru');
        return AssignmentCard(
          assignment: assignment,
          authorName: authorName,
          isTeacher: widget.isTeacher,
          currentUserId: widget.currentUserId,
          classId: widget.classId,
        );
      },
    );
  }
}
