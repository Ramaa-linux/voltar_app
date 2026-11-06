import 'package:flutter/material.dart';
import 'package:voltar/models/learning_step.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/dashed_border_box.dart';

/// Renderer untuk satu blok konten di halaman detail.
class ContentBlockRenderer extends StatelessWidget {
  const ContentBlockRenderer({super.key, required this.block, required this.index});

  final ContentBlock block;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: switch (block.type) {
        ContentBlockType.text => _TextBlock(text: block.data),
        ContentBlockType.code => _CodeBlock(code: block.data),
        ContentBlockType.image => _ImagePlaceholder(imageUrl: block.data),
        ContentBlockType.heading => _HeadingBlock(text: block.data),
      },
    );
  }
}

class _HeadingBlock extends StatelessWidget {
  const _HeadingBlock({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTypography.heading);
  }
}

class _TextBlock extends StatelessWidget {
  const _TextBlock({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTypography.body);
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: SelectableText(
        code,
        style: AppTypography.body.copyWith(
          fontFamily: 'monospace',
          fontSize: 13,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return DashedBorderBox(
      height: 180,
      text: 'Gambar: $imageUrl\n\n(Tap untuk lihat fullscreen di Fase 3+)',
    );
  }
}