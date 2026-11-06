import 'package:flutter/material.dart';
import 'package:voltar/models/learning_step.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/volt_chip.dart';
import 'package:voltar/pages/materi/detail/content_block_renderer.dart';
import 'package:voltar/pages/materi/detail/bottom_action_bar.dart';
import 'package:voltar/pages/materi/detail/praktik/led_animation.dart';
import 'package:voltar/pages/materi/detail/praktik/ohm_law_animation.dart';
import 'package:voltar/pages/materi/detail/praktik/push_button_sim.dart';
import 'package:voltar/pages/materi/detail/praktik/resistor_calculator.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

/// Konten utama halaman detail materi (3 tab: Bacaan, Video, Praktik).
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
  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _initYoutube();
  }

  void _initYoutube() {
    final url = widget.step.videoUrl;
    if (url == null || url.isEmpty) return;
    try {
      final videoId = YoutubePlayerController.convertUrlToId(url);
      if (videoId != null && videoId.isNotEmpty) {
        _youtubeController = YoutubePlayerController.fromVideoId(
          videoId: videoId,
          autoPlay: false,
          params: const YoutubePlayerParams(
            showControls: true,
            showFullscreenButton: true,
            playsInline: true,
          ),
        );
      }
    } catch (_) {
      // Ignore in test environment
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _youtubeController?.close();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
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

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              LinearProgressIndicator(
                value: _scrollProgress,
                backgroundColor: AppColors.border,
                color: AppColors.primary,
                minHeight: 3,
              ),
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
              if (step.heroImageUrl != null && step.heroImageUrl!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.pagePadding,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    child: SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: InteractiveViewer(
                        clipBehavior: Clip.none,
                        minScale: 1.0,
                        maxScale: 4.0,
                        child: Image.asset(
                          step.heroImageUrl!,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.grey.shade200,
                            alignment: Alignment.center,
                            child: Text(
                              'Gambar tidak ditemukan',
                              style: AppTypography.caption,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: AppSpacing.sm),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.pagePadding,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    step.description,
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              const TabBar(
                labelColor: AppColors.primaryDark,
                unselectedLabelColor: AppColors.textTertiary,
                indicatorColor: AppColors.primary,
                tabs: <Widget>[
                  Tab(text: 'Bacaan'),
                  Tab(text: 'Video'),
                  Tab(text: 'Praktik'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    _buildReadingTab(step),
                    _buildVideoTab(step),
                    _buildPracticeTab(step),
                  ],
                ),
              ),
              BottomActionBar(
                isDone: _isDone,
                onMarkDone: () => _showMarkDoneDialog(context, step),
              ),
            ],
          ),
        ),
      ),
    );
  }

    Widget _buildReadingTab(LearningStep step) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (int i = 0; i < (step.content?.length ?? 0); i++)
            ContentBlockRenderer(block: step.content![i], index: i),
        ],
      ),
    );
  }

  Widget _buildVideoTab(LearningStep step) {
    final summary = step.videoSummary ?? const <ContentBlock>[];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (_youtubeController != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.card),
              child: YoutubePlayer(
                controller: _youtubeController!,
                aspectRatio: 16 / 9,
              ),
            )
          else
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppRadius.card),
                border: Border.all(color: AppColors.border),
              ),
              alignment: Alignment.center,
              child: Text(
                step.videoUrl ?? 'Video tidak tersedia',
                style: AppTypography.bodyMuted,
              ),
            ),
          const SizedBox(height: AppSpacing.lg),
          if (summary.isNotEmpty) ...<Widget>[
            const Text('Ringkasan Video', style: AppTypography.title),
            const SizedBox(height: AppSpacing.sm),
            Container(
              height: 250,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppRadius.card),
                border: Border.all(color: AppColors.border),
              ),
              child: ListView.builder(
                key: const Key('video_summary_list'),
                itemCount: summary.length,
                itemBuilder: (context, index) {
                  return ContentBlockRenderer(
                    block: summary[index],
                    index: index,
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPracticeTab(LearningStep step) {
    return switch (step.id) {
      'l1_kom_resistor' => const ResistorCalculator(),
      'l1_kom_led' => const LedAnimation(),
      'l1_kom_tactile_switch' => const PushButtonSim(),
      'l1_kom_hukum_ohm' => const OhmLawAnimation(),
      _ => Padding(
          padding: const EdgeInsets.all(AppSpacing.pagePadding),
          child: Center(
            child: Text(
              'Simulasi praktik untuk ${step.title} segera hadir.',
              style: AppTypography.bodyMuted,
              textAlign: TextAlign.center,
            ),
          ),
        ),
    };
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