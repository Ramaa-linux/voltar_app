import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:cloud_firestore/cloud_firestore.dart";

import "../../pages/kelas/detail_kelas_page.dart";
import "../../services/auth_service.dart";
import "../../theme/app_borders.dart";
import "../../theme/app_colors.dart";
import "../../theme/app_spacing.dart";
import "../../theme/app_typography.dart";
import "../../utils/volt_feedback.dart";
import "../../widgets/app_icon.dart";
import "../../widgets/press_scale.dart";
import "../../widgets/volt_button.dart";
import "../../widgets/volt_card.dart";
import "../../utils/localization_helper.dart";

/// Halaman Kelas Siswa.
/// Menampilkan kelas yang diikuti siswa (berdasarkan classId di users).
/// Jika belum punya kelas, tampilkan form "Gabung Kelas" sama seperti di HomePage.
class KelasPage extends ConsumerWidget {
  const KelasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Map<String, dynamic>?> profileAsync = ref.watch(
      userProfileProvider,
    );
    final String? classId = profileAsync.value?["classId"] as String?;

    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pagePadding,
                AppSpacing.xl,
                AppSpacing.pagePadding,
                AppSpacing.lg,
              ),
              child: Text(
                context.t("kelasSaya"),
                style: AppTypography.heading.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pagePadding),
            sliver: classId == null || classId.isEmpty
                ? SliverToBoxAdapter(
                    child: _JoinClassForm(
                      authService: ref.read(authServiceProvider),
                    ),
                  )
                : StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>( 
                    stream: FirebaseFirestore.instance
                        .collection("classes")
                        .doc(classId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SliverToBoxAdapter(child: _KelasCardSkeleton());
                      }

                      if (snapshot.hasError ||
                          !snapshot.hasData ||
                          !snapshot.data!.exists) {
                        return SliverToBoxAdapter(child: _KelasCardError());
                      }

                      final data = snapshot.data!.data()!;
                      final String className = data["name"] as String? ?? "Tanpa Nama";
                      final String classCode = data["classCode"] as String? ?? "-";
                      final int studentCount = data["studentCount"] as int? ?? 0;
                      final String teacherId = data["teacherId"] as String? ?? "";

                      return SliverList.separated(
                        itemCount: 1,
                        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
                        itemBuilder: (context, index) => _KelasCard(
                          className: className,
                          classCode: classCode,
                          studentCount: studentCount,
                          teacherId: teacherId,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailKelasPage(classId: classId, className: className, classCode: classCode, teacherId: teacherId, isTeacher: false)));
                          },
                        ),
                      );
                    },
                  ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.navBarClearance)),
        ],
      ),
    );
  }
}

/// Form bergabung ke kelas (reused from HomePage).
class _JoinClassForm extends ConsumerStatefulWidget {
  const _JoinClassForm({required this.authService});

  final AuthService authService;

  @override
  ConsumerState<_JoinClassForm> createState() => _JoinClassFormState();
}

class _JoinClassFormState extends ConsumerState<_JoinClassForm> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VoltCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppRadius.card),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(AppRadius.input),
                      ),
                      child: const AppIcon(
                        AppIconName.folder,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            context.t('kelasNoClassYet'),
                            style: AppTypography.title.copyWith(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            context.t("masukkanKodeKelas"),
                            style: AppTypography.bodyMuted.copyWith(
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: context.t("kodeKelas"),
                    hintText: context.t("classCodeHint"),
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.characters,
                  maxLength: 6,
                  enabled: !_isLoading,
                ),
                const SizedBox(height: AppSpacing.md),
                VoltButton(
                  label: context.t("gabungKelas"),
                  onPressed: _isLoading ? null : _handleJoinClass,
                  fullWidth: true,
                  variant: VoltButtonVariant.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleJoinClass() async {
    final String code = _controller.text.trim().toUpperCase();
    if (code.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      await widget.authService.joinClass(code);
      if (mounted) {
        showVoltSnackBar(context, context.t('kelasJoinSuccess'));
        _controller.clear();
      }
    } on AuthException catch (e) {
      if (mounted) {
        showVoltSnackBar(context, e.message);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}

/// Kartu info kelas yang sudah digabung.
class _KelasCard extends StatelessWidget {
  const _KelasCard({
    required this.className,
    required this.classCode,
    required this.studentCount,
    required this.teacherId,
    required this.onTap,
  });

  final String className;
  final String classCode;
  final int studentCount;
  final String teacherId;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: AppBorders.standard,
          boxShadow: AppShadows.card,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.button),
                  ),
                  child: const Center(
                    child: AppIcon(
                      AppIconName.folder,
                      size: 24,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        className,
                        style: AppTypography.title.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: <Widget>[
                          Text(
                            context.t("studentCount", args: [studentCount.toString()]),
                            style: AppTypography.bodyMuted,
                          ),
                          const SizedBox(width: AppSpacing.md),
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
                              classCode,
                              style: AppTypography.label.copyWith(
                                color: AppColors.primaryDark,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            // Action buttons
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onTap,
                    icon: const AppIcon(AppIconName.info, size: 16),
                    label: Text(context.t("lihatDetail")),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Future: navigate to tugas/absen for this class
                    },
                    icon: const AppIcon(AppIconName.checkSquare, size: 16),
                    label: Text(context.t("tugasDanAbsen")),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                      ),
                    ),
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

/// Skeleton loading untuk kartu kelas.
class _KelasCardSkeleton extends StatelessWidget {
  const _KelasCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: AppBorders.standard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(AppRadius.button),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 120,
                      height: 18,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(AppRadius.input),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Container(
                      width: 80,
                      height: 14,
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
        ],
      ),
    );
  }
}

/// Error state untuk kartu kelas.
class _KelasCardError extends StatelessWidget {
  const _KelasCardError();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.errorLight,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.error, width: 1),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.error,
              borderRadius: BorderRadius.circular(AppRadius.input),
            ),
            child: const Icon(Icons.error_outline, size: 20, color: Colors.white),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  context.t("kelasTidakDitemukan"),
                  style: AppTypography.title.copyWith(color: AppColors.error),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  context.t("hubungiGuruKodeKelas"),
                  style: AppTypography.bodyMuted.copyWith(color: AppColors.error),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}










