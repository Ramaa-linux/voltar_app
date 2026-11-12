import 'dart:io';

void main() {
  final file = File('lib/pages/materi/detail/materi_detail_view.dart');
  var content = file.readAsStringSync();
  const target = 'void _showMarkDoneDialog';
  final idx = content.indexOf(target);
  print('idx: $idx, contains: ${content.contains("_buildReadingTab")}');
  if (idx != -1 && !content.contains('_buildReadingTab')) {
    const methods = r'''  Widget _buildReadingTab(LearningStep step) {
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
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Center(
        child: Text(
          'Simulasi praktik untuk ${step.title} segera hadir.',
          style: AppTypography.bodyMuted,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  ''';
    content = content.substring(0, idx) + methods + content.substring(idx);
    // Also fix unnecessary underscores:
    content = content.replaceAll('errorBuilder: (_, __, ___)', 'errorBuilder: (_, _, _)');
    file.writeAsStringSync(content);
    print('Successfully inserted tab methods');
  }
}