import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';

class VirtualPotentiometer extends StatelessWidget {
  const VirtualPotentiometer({
    super.key,
    required this.adcValue,
    required this.onChanged,
    required this.mappedLabel,
    required this.mapFormulaText,
    required this.accentColor,
  });

  final int adcValue;
  final ValueChanged<int> onChanged;
  final String mappedLabel;
  final String mapFormulaText;
  final Color accentColor;

  void _handlePan(Offset localPos, Size knobSize) {
    final Offset center = Offset(knobSize.width / 2, knobSize.height / 2);
    final Offset delta = localPos - center;
    double angleFromBottom = math.atan2(delta.dy, delta.dx) - (math.pi / 2);
    while (angleFromBottom < -math.pi) {
      angleFromBottom += 2 * math.pi;
    }
    while (angleFromBottom > math.pi) {
      angleFromBottom -= 2 * math.pi;
    }
    const double maxHalfSpan = 3 * math.pi / 4;
    final double clamped = angleFromBottom.clamp(-maxHalfSpan, maxHalfSpan);
    final double norm = (clamped + maxHalfSpan) / (2 * maxHalfSpan);
    final int nextAdc = (norm * 1023).round().clamp(0, 1023);
    if (nextAdc != adcValue) onChanged(nextAdc);
  }

  @override
  Widget build(BuildContext context) {
    const Size knobSize = Size(108, 108);
    final int clampedAdc = adcValue.clamp(0, 1023);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.button),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Semantics(
                label: 'Knob Potensiometer ADC $clampedAdc, $mappedLabel',
                slider: true,
                value: '$clampedAdc',
                child: GestureDetector(
                  key: const Key('virtual_potentiometer_knob'),
                  onPanDown: (DragDownDetails d) {
                    HapticFeedback.selectionClick();
                    _handlePan(d.localPosition, knobSize);
                  },
                  onPanUpdate: (DragUpdateDetails d) => _handlePan(d.localPosition, knobSize),
                  child: SizedBox(
                    width: knobSize.width,
                    height: knobSize.height,
                    child: CustomPaint(
                      painter: _PotKnobPainter(adcValue: clampedAdc, accentColor: accentColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Potensiometer Rotary (A0)',
                      style: AppTypography.label.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.input),
                        border: Border.all(color: accentColor.withValues(alpha: 0.45)),
                      ),
                      child: Text(
                        'ADC: $clampedAdc → $mappedLabel',
                        style: AppTypography.label.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      mapFormulaText,
                      style: AppTypography.overline.copyWith(
                        fontFamily: 'monospace',
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: accentColor,
              inactiveTrackColor: AppColors.borderStrong,
              thumbColor: accentColor,
              overlayColor: accentColor.withValues(alpha: 0.14),
              trackHeight: 5,
            ),
            child: Slider(
              key: const Key('virtual_potentiometer_slider'),
              value: clampedAdc.toDouble(),
              min: 0,
              max: 1023,
              onChanged: (double v) => onChanged(v.round()),
            ),
          ),
        ],
      ),
    );
  }
}

class _PotKnobPainter extends CustomPainter {
  const _PotKnobPainter({required this.adcValue, required this.accentColor});

  final int adcValue;
  final Color accentColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double outerR = size.width * 0.43;
    final double knobR = size.width * 0.31;
    const double startAngle = 3 * math.pi / 4;
    const double sweepSpan = 3 * math.pi / 2;
    final double norm = (adcValue.clamp(0, 1023)) / 1023.0;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: outerR),
      startAngle,
      sweepSpan,
      false,
      Paint()
        ..color = AppColors.borderStrong
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: outerR),
      startAngle,
      sweepSpan * norm,
      false,
      Paint()
        ..color = accentColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5.5
        ..strokeCap = StrokeCap.round,
    );

    final Paint tickPaint = Paint()
      ..color = AppColors.textSecondary
      ..strokeWidth = 1.4;
    for (int i = 0; i <= 10; i++) {
      final double a = startAngle + (sweepSpan * (i / 10.0));
      final Offset p1 = center + Offset(math.cos(a), math.sin(a)) * (outerR + 4);
      final Offset p2 = center + Offset(math.cos(a), math.sin(a)) * (outerR + 8);
      canvas.drawLine(p1, p2, tickPaint);
    }

    canvas.drawCircle(
      center + const Offset(0, 3),
      knobR,
      Paint()..color = AppColors.shadow.withValues(alpha: 0.22),
    );
    canvas.drawCircle(center, knobR, Paint()..color = AppColors.circuitPinHeader);
    canvas.drawCircle(center, knobR - 3, Paint()..color = AppColors.textPrimary);

    final double pointerAngle = startAngle + sweepSpan * norm;
    final Offset pInner = center + Offset(math.cos(pointerAngle), math.sin(pointerAngle)) * (knobR * 0.28);
    final Offset pOuter = center + Offset(math.cos(pointerAngle), math.sin(pointerAngle)) * (knobR * 0.82);
    canvas.drawLine(
      pInner,
      pOuter,
      Paint()
        ..color = accentColor
        ..strokeWidth = 3.2
        ..strokeCap = StrokeCap.round,
    );

    canvas.drawCircle(center, 4, Paint()..color = AppColors.circuitMetalLight);
  }

  @override
  bool shouldRepaint(covariant _PotKnobPainter oldDelegate) =>
      oldDelegate.adcValue != adcValue || oldDelegate.accentColor != accentColor;
}
