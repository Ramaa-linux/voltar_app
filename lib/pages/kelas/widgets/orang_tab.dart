import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../theme/app_borders.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_icon.dart';
import 'orang_tab_helpers.dart';
import '../../../utils/localization_helper.dart';

/// A simple skeleton loader for member list items.
class _MemberSkeleton extends StatelessWidget {
  const _MemberSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.button),
        border: Border.all(color: AppColors.border),
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

class OrangTab extends StatelessWidget {
  final String classId;
  final String? teacherId;
  final String? classCode;
  final double bottomInset;

  const OrangTab({
    super.key,
    required this.classId,
    this.teacherId,
    this.classCode,
    this.bottomInset = AppSpacing.navBarClearance,
  });

  @override
  Widget build(BuildContext context) {
    final studentsStream = FirebaseFirestore.instance
        .collection('users')
        .where('classId', isEqualTo: classId)
        .snapshots();

    return CustomScrollView(
      slivers: [
        if (teacherId != null && teacherId!.isNotEmpty) ..._buildTeacherSection(context),
        ..._buildStudentSection(studentsStream),
        SliverToBoxAdapter(child: SizedBox(height: bottomInset)),
      ],
    );
  }

  List<Widget> _buildTeacherSection(BuildContext context) {
    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.pagePadding,
            AppSpacing.lg,
            AppSpacing.pagePadding,
            AppSpacing.sm,
          ),
          child: Text(
            context.t('guru').toUpperCase(),
            style: AppTypography.label.copyWith(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pagePadding),
        sliver: SliverToBoxAdapter(
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(teacherId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const _MemberSkeleton();
              }
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return MemberTile(
                  name: context.t('guru'),
                  email: '-',
                  role: context.t('guru'),
                  isTeacher: true,
                );
              }
              final data = snapshot.data!.data()!;
              final name = data['name'] as String? ?? context.t('guru');
              final email = data['email'] as String? ?? '';
              return MemberTile(
                name: name,
                email: email,
                role: context.t('guru'),
                isTeacher: true,
              );
            },
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildStudentSection(
      Stream<QuerySnapshot<Map<String, dynamic>>> studentsStream) {
    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.pagePadding,
            AppSpacing.xl,
            AppSpacing.pagePadding,
            AppSpacing.sm,
          ),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: studentsStream,
            builder: (context, snapshot) {
              final count = snapshot.data?.docs.length ?? 0;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.t('siswaTab', args: [count.toString()]),
                    style: AppTypography.label.copyWith(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                  if (classCode != null && classCode!.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(AppRadius.input),
                      ),
                      child: Text(
                        context.t('kodeLabel', args: [classCode!]),
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pagePadding),
        sliver: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: studentsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SliverList.separated(
                itemCount: 3,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.xs),
                itemBuilder: (_, _) => const _MemberSkeleton(),
              );
            }
            if (snapshot.hasError) {
              return SliverToBoxAdapter(
                child: TabEmptyState(
                  icon: AppIconName.info,
                  title: context.t('gagalMemuat'),
                  message: context.t('gagalMemuatSiswa'),
                ),
              );
            }
            final docs = snapshot.data?.docs ?? [];
            if (docs.isEmpty) {
              return SliverToBoxAdapter(
                child: EmptyStudentsState(classCode: classCode ?? '-'),
              );
            }
            final sortedDocs = List.of(docs)
              ..sort((a, b) {
                final nameA =
                    (a.data()['name'] as String? ?? '').toLowerCase();
                final nameB =
                    (b.data()['name'] as String? ?? '').toLowerCase();
                return nameA.compareTo(nameB);
              });
            return SliverList.separated(
              itemCount: sortedDocs.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: AppSpacing.xs),
              itemBuilder: (context, index) {
                final data = sortedDocs[index].data();
                final name = data['name'] as String? ?? context.t('tanpaNama');
                final email = data['email'] as String? ?? '';
                return MemberTile(
                  name: name,
                  email: email,
                  index: index + 1,
                  isTeacher: false,
                );
              },
            );
          },
        ),
      ),
    ];
  }
}