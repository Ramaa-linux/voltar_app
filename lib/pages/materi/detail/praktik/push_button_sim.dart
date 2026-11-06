import 'package:flutter/material.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/volt_card.dart';

/// Praktik interaktif: Virtual Push Button (Tactile Switch) & LED.
class PushButtonSim extends StatefulWidget {
  const PushButtonSim({super.key});

  @override
  State<PushButtonSim> createState() => _PushButtonSimState();
}

class _PushButtonSimState extends State<PushButtonSim> {
  bool _isPressed = false;

  void _onPressDown() {
    if (!_isPressed) setState(() => _isPressed = true);
  }

  void _onPressUp() {
    if (_isPressed) setState(() => _isPressed = false);
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
                const Text('Simulasi Push Button', style: AppTypography.title),
                const SizedBox(height: AppSpacing.xs),
                const Text(
                  'Tekan dan tahan tombol tactile switch di bawah untuk mengalirkan arus ke LED.',
                  style: AppTypography.bodyMuted,
                ),
                const SizedBox(height: AppSpacing.xl),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(child: _buildSwitchWidget()),
                          Flexible(child: _buildWireIndicator()),
                          Flexible(child: _buildLedWidget()),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: _isPressed
                              ? AppColors.success.withValues(alpha: 0.15)
                              : const Color(0xFF0F172A),
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          border: Border.all(
                            color: _isPressed ? AppColors.success : Colors.transparent,
                          ),
                        ),
                        child: Text(
                          _isPressed
                              ? 'RANGKAIAN TERTUTUP: ARUS MENGALIR'
                              : 'RANGKAIAN TERBUKA: STANDBY',
                          style: AppTypography.label.copyWith(
                            color: _isPressed
                                ? AppColors.success
                                : const Color(0xFF94A3B8),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const VoltCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Prinsip Normally Open (NO)', style: AppTypography.title),
                SizedBox(height: AppSpacing.xs),
                Text(
                  'Tactile switch adalah sakelar sesaat bertipe Normally Open (NO). '
                  'Saat dilepas, kontak pegas terbuka sehingga arus terputus. '
                  'Saat ditekan, pelat logam internal menghubungkan kaki-kaki sakelar sehingga sirkuit tertutup dan LED menyala.',
                  style: AppTypography.body,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildSwitchWidget() {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTapDown: (_) => _onPressDown(),
          onTapUp: (_) => _onPressUp(),
          onTapCancel: _onPressUp,
          child: AnimatedScale(
            scale: _isPressed ? 0.92 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: const Color(0xFF94A3B8),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF64748B), width: 3),
                boxShadow: _isPressed
                    ? <BoxShadow>[]
                    : <BoxShadow>[
                        const BoxShadow(
                          color: Colors.black45,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
              ),
              child: Center(
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: _isPressed
                          ? <Color>[const Color(0xFF1E293B), const Color(0xFF0F172A)]
                          : <Color>[const Color(0xFF334155), const Color(0xFF0F172A)],
                    ),
                    border: Border.all(
                      color: _isPressed ? AppColors.accent : const Color(0xFF475569),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.touch_app,
                      size: 24,
                      color: _isPressed ? AppColors.accent : const Color(0xFF94A3B8),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          _isPressed ? 'Ditekan' : 'Tekan & Tahan',
          style: AppTypography.label.copyWith(
            color: _isPressed ? AppColors.accent : const Color(0xFFCBD5E1),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildWireIndicator() {
    return Column(
      children: <Widget>[
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 48,
          height: 6,
          decoration: BoxDecoration(
            color: _isPressed ? AppColors.success : const Color(0xFF475569),
            borderRadius: BorderRadius.circular(3),
            boxShadow: _isPressed
                ? <BoxShadow>[
                    BoxShadow(
                      color: AppColors.success.withValues(alpha: 0.8),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          _isPressed ? '>>>' : '---',
          style: AppTypography.overline.copyWith(
            color: _isPressed ? AppColors.success : const Color(0xFF64748B),
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildLedWidget() {
    return Column(
      children: <Widget>[
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isPressed
                ? const Color(0xFFEF4444)
                : const Color(0xFFEF4444).withValues(alpha: 0.25),
            border: Border.all(
              color: _isPressed ? Colors.white : const Color(0xFF991B1B),
              width: 3,
            ),
            boxShadow: _isPressed
                ? <BoxShadow>[
                    BoxShadow(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.9),
                      blurRadius: 24,
                      spreadRadius: 8,
                    ),
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.8),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ]
                : <BoxShadow>[
                    const BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
          ),
          child: Center(
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isPressed
                    ? Colors.white.withValues(alpha: 0.9)
                    : Colors.transparent,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          _isPressed ? 'LED ON' : 'LED OFF',
          style: AppTypography.label.copyWith(
            color: _isPressed ? const Color(0xFFEF4444) : const Color(0xFF94A3B8),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

}