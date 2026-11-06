import 'dart:async';
import 'package:flutter/material.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/volt_button.dart';
import 'package:voltar/widgets/volt_card.dart';

/// Praktik interaktif: Animasi Running LED (chaser).
class LedAnimation extends StatefulWidget {
  const LedAnimation({super.key});

  @override
  State<LedAnimation> createState() => _LedAnimationState();
}

class _LedAnimationState extends State<LedAnimation> {
  static const List<Color> _ledColors = <Color>[
    Color(0xFFEF4444),
    Color(0xFFF59E0B),
    Color(0xFF10B981),
    Color(0xFF3B82F6),
  ];

  static const List<String> _ledLabels = <String>[
    'LED 1',
    'LED 2',
    'LED 3',
    'LED 4',
  ];

  bool _isRunning = false;
  int _activeLedIndex = -1;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleAnimation() {
    if (_isRunning) {
      _stopAnimation();
    } else {
      _startAnimation();
    }
  }

  void _startAnimation() {
    _timer?.cancel();
    setState(() {
      _isRunning = true;
      _activeLedIndex = 0;
    });

    _timer = Timer.periodic(const Duration(milliseconds: 350), (timer) {
      if (!mounted) return;
      setState(() {
        _activeLedIndex = (_activeLedIndex + 1) % _ledColors.length;
      });
    });
  }

  void _stopAnimation() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _activeLedIndex = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          VoltCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Simulasi Running LED', style: AppTypography.title),
                const SizedBox(height: AppSpacing.xs),
                const Text(
                  'Amati bagaimana pin digital mikrokontroler menyalakan deretan LED bergantian.',
                  style: AppTypography.bodyMuted,
                ),
                const SizedBox(height: AppSpacing.xl),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.xxl,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    border: Border.all(color: const Color(0xFF334155), width: 2),
                    boxShadow: AppShadows.card,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(_ledColors.length, (index) {
                          final bool isOn = _activeLedIndex == index;
                          final Color color = _ledColors[index];

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              _buildLedBulb(color: color, isOn: isOn),
                              const SizedBox(height: AppSpacing.md),
                              Text(
                                _ledLabels[index],
                                style: AppTypography.overline.copyWith(
                                  color: isOn
                                      ? Colors.white
                                      : const Color(0xFF64748B),
                                  fontWeight: isOn
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F172A),
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Text(
                          _isRunning
                              ? 'Aktif: Pin D${_activeLedIndex + 8} HIGH'
                              : 'Status: Standby (Semua Pin LOW)',
                          style: AppTypography.label.copyWith(
                            color: _isRunning
                                ? AppColors.accent
                                : const Color(0xFF94A3B8),
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                VoltButton(
                  label: _isRunning ? 'Hentikan Animasi' : 'Jalankan Animasi',
                  fullWidth: true,
                  variant: _isRunning
                      ? VoltButtonVariant.secondary
                      : VoltButtonVariant.primary,
                  onPressed: _toggleAnimation,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const VoltCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Konsep Kerja', style: AppTypography.title),
                SizedBox(height: AppSpacing.xs),
                Text(
                  '1. Mikrokontroler mengirim sinyal HIGH (5V) ke satu pin.\n'
                  '2. LED menyala karena arus mengalir melewati resistor ke GND.\n'
                  '3. Rutin loop mematikan LED (LOW) lalu beralih ke pin berikutnya.',
                  style: AppTypography.body,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLedBulb({required Color color, required bool isOn}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isOn ? color : color.withValues(alpha: 0.2),
        border: Border.all(
          color: isOn ? Colors.white : color.withValues(alpha: 0.4),
          width: 2.5,
        ),
        boxShadow: isOn
            ? <BoxShadow>[
                BoxShadow(
                  color: color.withValues(alpha: 0.9),
                  blurRadius: 20,
                  spreadRadius: 6,
                ),
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.8),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ]
            : <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Center(
        child: Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isOn
                ? Colors.white.withValues(alpha: 0.9)
                : Colors.transparent,
          ),
        ),
      ),
    );
  }
}
