import 'package:flutter/material.dart';
import 'package:voltar/models/learning_step.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/volt_chip.dart';
import 'package:voltar/pages/materi/detail/content_block_renderer.dart';
import 'package:voltar/pages/materi/detail/bottom_action_bar.dart';

/// Konten utama halaman detail materi (dengan scroll progress tracking).
class MateriDetailView extends StatefulWidget {
  const MateriDetailView({
    super.key,
    required this.step,
    required this.levelNumber,
  });

  final LearningStep step;
  final int levelNumber;

  @override
  State<MateriDetailView> createState() => _MateriDetailViewState();
}

class _MateriDetailViewState extends State<MateriDetailView> {
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0.0;
  bool _isDone = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final double maxScroll = _scrollController.position.maxScrollExtent;
    if (maxScroll > 0) {
      final double progress = _scrollController.offset / maxScroll;
      setState(() => _scrollProgress = progress.clamp(0.0, 1.0));
    }
  }

  @override
  Widget build(BuildContext context) {
    final LearningStep step = widget.step;
    final VoltChipStatus chipStatus =
        _isDone ? VoltChipStatus.done : VoltChipStatus.active;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            // Scroll Progress Bar
            LinearProgressIndicator(
              value: _scrollProgress,
              backgroundColor: AppColors.border,
              color: AppColors.primary,
              minHeight: 3,
            ),
            // Header
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: const AppIcon.arrowLeft(
                      size: AppIconSize.md,
                      color: AppColors.textPrimary,
                    ),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'LEVEL ${widget.levelNumber}',
                          style: AppTypography.overline.copyWith(
                            color: AppColors.primaryDark,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(step.title, style: AppTypography.title),
                      ],
                    ),
                  ),
                  VoltChip(
                    label: switch (chipStatus) {
                      VoltChipStatus.done => 'Selesai',
                      VoltChipStatus.active => 'Sedang Belajar',
                      VoltChipStatus.locked => 'Terkunci',
                    },
                    status: chipStatus,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            // Description
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pagePadding,
              ),
              child: Text(
                step.description,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            // Content blocks
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(AppSpacing.pagePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (int i = 0; i < (step.content?.length ?? 0); i++)
                      ContentBlockRenderer(block: step.content![i], index: i),
                  ],
                ),
              ),
            ),
            // Bottom action bar
            BottomActionBar(
              isDone: _isDone,
              onMarkDone: () => _showMarkDoneDialog(context, step),
            ),
          ],
        ),
      ),
    );
  }

  void _showMarkDoneDialog(BuildContext context, LearningStep step) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Tandai Selesai?'),
        content: Text(
          'Apakah kamu yakin ingin menandai "${step.title}" sebagai selesai?',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() => _isDone = true);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${step.title} ditandai selesai!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Tandai Selesai'),
          ),
        ],
      ),
    );
  }
}