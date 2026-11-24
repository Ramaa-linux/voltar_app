import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:cloud_firestore/cloud_firestore.dart";

import "../../router/app_routes.dart";
import "../../services/auth_service.dart";
import "../../theme/app_borders.dart";
import "../../theme/app_colors.dart";
import "../../theme/app_spacing.dart";
import "../../theme/app_typography.dart";
import "../../utils/volt_feedback.dart";
import "../../utils/localization_helper.dart";
import "../../widgets/app_icon.dart";
import "../../widgets/press_scale.dart";
import "../../widgets/volt_button.dart";

/// Halaman Daftar Kelas Guru.
/// Menggunakan Stream dari Firestore untuk menampilkan kelas yang dibuat guru.
class GuruKelasPage extends ConsumerWidget {
  const GuruKelasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthService authService = ref.watch(authServiceProvider);
    final String? teacherId = authService.currentUser?.uid;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pagePadding,
                AppSpacing.xl,
                AppSpacing.pagePadding,
                AppSpacing.lg,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          context.t("daftarKelas"),
                          style: AppTypography.heading.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          context.t("kelolaKelasYangAndaAmpu"),
                          style: AppTypography.bodyMuted,
                        ),
                      ],
                    ),
                  ),
                  VoltButton(
                    label: context.t("guruCreateClass"),
                    onPressed: () => _showCreateClassDialog(context, ref),
                    variant: VoltButtonVariant.primary,
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pagePadding),
            sliver: teacherId == null
                ? SliverToBoxAdapter(
                    child: _EmptyState(
                      icon: AppIconName.info,
                      title: context.t("guruNotLoggedIn"),
                      message: context.t("guruLoginPrompt"),
                    ),
                  )
                : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("classes")
                        .where("teacherId", isEqualTo: teacherId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SliverList.separated(
                          itemCount: 3,
                          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
                          itemBuilder: (_, _) => _KelasCardSkeleton(),
                        );
                      }

                      if (snapshot.hasError) {
                        return SliverToBoxAdapter(
                          child: _EmptyState(
                            icon: AppIconName.info,
                            title: context.t("gagalMemuat"),
                            message: "${context.t("gagalMemuat")}: ${snapshot.error}",
                          ),
                        );
                      }

                      final docs = snapshot.data?.docs ?? [];

                      if (docs.isEmpty) {
                        return SliverToBoxAdapter(
                          child: _EmptyState(
                            icon: AppIconName.folder,
                            title: context.t("guruNoClasses"),
                            message: context.t("guruCreateClassPrompt"),
                          ),
                        );
                      }

                      // Sort by createdAt descending in Dart (no Firestore index needed)
                      docs.sort((a, b) {
                        final aTime = a.data()["createdAt"] as Timestamp?;
                        final bTime = b.data()["createdAt"] as Timestamp?;
                        if (aTime == null && bTime == null) return 0;
                        if (aTime == null) return 1;
                        if (bTime == null) return -1;
                        return bTime.compareTo(aTime); // descending
                      });

                      return SliverList.separated(
                        itemCount: docs.length,
                        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
                        itemBuilder: (context, index) {
                          final data = docs[index].data();
                          final String classId = docs[index].id;
                          final String nama = data["name"] as String? ?? "Tanpa Nama";
                          final String classCode = data["classCode"] as String? ?? "-";

                          return _KelasCard(
                            nama: nama,
                            classId: classId,
                            classCode: classCode,
                            onTap: () => context.push(
                              "${AppRoutes.guruKelas}/$classId",
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _showCreateClassDialog(BuildContext context, WidgetRef ref) async {
    final TextEditingController controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.t("guruCreateClassTitle")),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            decoration:  InputDecoration(
              labelText: context.t("guruClassNameLabel"),
              hintText: context.t("guruClassNameHint"),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return context.t("guruClassNameRequired");
              }
              return null;
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.t("guruCancel")),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState?.validate() ?? false) {
                Navigator.pop(context);
                await _createClass(ref, controller.text.trim());
              }
            },
            child: Text(context.t("guruCreate")),
          ),
        ],
      ),
    );
  }

  Future<void> _createClass(WidgetRef ref, String nama) async {
    final AuthService authService = ref.read(authServiceProvider);
    final String? teacherId = authService.currentUser?.uid;

    if (teacherId == null) {
      showVoltSnackBar(
        ref.context!,
        ref.context!.t("guruLoginFirst"),
      );
      return;
    }

    try {
      final classCode = _generateClassCode();
      final now = FieldValue.serverTimestamp();

      await FirebaseFirestore.instance.collection("classes").add({
        "name": nama,
        "classCode": classCode,
        "teacherId": teacherId,
        "studentCount": 0,
        "createdAt": now,
        "updatedAt": now,
      });

      showVoltSnackBar(
        ref.context!,
        ref.context!.t("guruClassCreated", args: [nama, classCode]),
      );
    } catch (e) {
      showVoltSnackBar(
        ref.context!,
        ref.context!.t("guruClassCreateFailed", args: [e.toString()]),
      );
    }
  }

  String _generateClassCode() {
    const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    final random = DateTime.now().millisecondsSinceEpoch;
    final buffer = StringBuffer();
    for (int i = 0; i < 6; i++) {
      buffer.write(chars[(random >> (i * 4)) % chars.length]);
    }
    return buffer.toString();
  }
}

class _KelasCard extends ConsumerWidget {
  const _KelasCard({
    required this.nama,
    required this.classId,
    required this.classCode,
    required this.onTap,
  });

  final String nama;
  final String classId;
  final String classCode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<int>(
      future: FirebaseFirestore.instance
          .collection("users")
          .where("classId", isEqualTo: classId)
          .get()
          .then((snap) => snap.docs.length),
      builder: (context, snapshot) {
        final int siswa = snapshot.data ?? 0;
        return PressScale(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: AppBorders.standard,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(AppRadius.button),
                  ),
                  child: Center(
                    child: AppIcon(AppIconName.folder, size: 24, color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(nama, style: AppTypography.title.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: <Widget>[
                          Text(context.t('guruKelasCardSiswa', args: [siswa]), style: AppTypography.bodyMuted),
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
                const AppIcon(AppIconName.chevronRight, size: 20, color: AppColors.textTertiary),
              ],
            ),
          ),
        );
      },
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
      child: Row(
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
    );
  }
}

/// Empty state widget.
class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.icon,
    required this.title,
    required this.message,
  });

  final AppIconName icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
      child: Column(
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: AppIcon(icon, size: 40, color: AppColors.primary),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(title, style: AppTypography.title.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: AppSpacing.xs),
          Text(message, style: AppTypography.bodyMuted, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
