import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/auth_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../utils/localization_helper.dart';
import 'widgets/create_post_sheets.dart';
import 'widgets/forum_tab.dart';
import 'widgets/orang_tab.dart';
import 'widgets/speed_dial_fab.dart';
import 'widgets/tugas_tab.dart';

/// Halaman Detail Kelas dengan 3 tab: Forum, Tugas, Orang.
/// Digunakan oleh Siswa (push dari KelasPage) dan Guru (push dari GuruKelasPage).
class DetailKelasPage extends ConsumerStatefulWidget {
  final String classId;
  final String className;
  final String classCode;
  final String teacherId;
  final bool isTeacher;

  const DetailKelasPage({
    super.key,
    required this.classId,
    required this.className,
    required this.classCode,
    required this.teacherId,
    required this.isTeacher,
  });

  @override
  ConsumerState<DetailKelasPage> createState() => _DetailKelasPageState();
}

class _DetailKelasPageState extends ConsumerState<DetailKelasPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final String _currentUserId;
  late final bool _isTeacher;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    final authService = ref.read(authServiceProvider);
    _currentUserId = authService.currentUser?.uid ?? '';
    _isTeacher = widget.isTeacher;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showCreateAnnouncementSheet() {
    showCreateAnnouncementSheet(
      context: context,
      classId: widget.classId,
      authorId: _currentUserId,
    );
  }

  void _showCreateAssignmentSheet() {
    showCreateAssignmentSheet(
      context: context,
      classId: widget.classId,
      authorId: _currentUserId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.className,
          style: AppTypography.title.copyWith(fontWeight: FontWeight.w700),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textTertiary,
          labelStyle: AppTypography.label.copyWith(fontWeight: FontWeight.w700),
          unselectedLabelStyle: AppTypography.label,
          tabs:  [
            Tab(text: context.t('kelasTabForum')),
            Tab(text: context.t('kelasTabTugas')),
            Tab(text: context.t('kelasTabOrang')),
          ],
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.background,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ForumTab(
            classId: widget.classId,
            currentUserId: _currentUserId,
            isTeacher: _isTeacher,
            teacherId: widget.teacherId,
          ),
          TugasTab(
            classId: widget.classId,
            currentUserId: _currentUserId,
            isTeacher: _isTeacher,
            teacherId: widget.teacherId,
          ),
          OrangTab(
            classId: widget.classId,
            teacherId: widget.teacherId,
            classCode: widget.classCode,
          ),
        ],
      ),
      floatingActionButton: _isTeacher
          ? SpeedDialFab(
              onCreateAnnouncement: _showCreateAnnouncementSheet,
              onCreateAssignment: _showCreateAssignmentSheet,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}



