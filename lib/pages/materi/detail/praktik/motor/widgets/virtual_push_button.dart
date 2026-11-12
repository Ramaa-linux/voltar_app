import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';

/// Tombol tekan 3D fisik dengan dukungan `onPressStart`, `onPressEnd`, dan `onTap`.
/// Menangani `onTapCancel` agar tahan tombol selalu berhenti meskipun jari keluar area.
class VirtualPushButton extends StatefulWidget {
  const VirtualPushButton({
    super.key,
    required this.label,
    required this.accentColor,
    this.onTap,
    this.onPressStart,
    this.onPressEnd,
    this.isActive = false,
    this.icon,
    this.compact = false,
  });

  final String label;
  final Color accentColor;
  final VoidCallback? onTap;
  final VoidCallback? onPressStart;
  final VoidCallback? onPressEnd;
  final bool isActive;
  final IconData? icon;
  final bool compact;

  @override
  State<VirtualPushButton> createState() => _VirtualPushButtonState();
}

class _VirtualPushButtonState extends State<VirtualPushButton> {
  bool _pressed = false;

  void _handleDown() {
    if (_pressed) return;
    setState(() => _pressed = true);
    HapticFeedback.selectionClick();
    widget.onPressStart?.call();
  }

  void _handleUp() {
    if (!_pressed) return;
    setState(() => _pressed = false);
    widget.onPressEnd?.call();
  }

  @override
  void deactivate() {
    if (_pressed) {
      _pressed = false;
      widget.onPressEnd?.call();
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final bool down = _pressed || widget.isActive;
    final Color bgColor = down ? widget.accentColor : AppColors.surface;
    final Color fgColor = down ? AppColors.textOnPrimary : AppColors.textPrimary;

    return Semantics(
      button: true,
      label: widget.label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => _handleDown(),
        onTapUp: (_) {
          _handleUp();
          widget.onTap?.call();
        },
        onTapCancel: _handleUp,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: AppSpacing.minTouchTarget,
            minWidth: AppSpacing.minTouchTarget,
          ),
          child: Container(
            transform: Matrix4.translationValues(0.0, _pressed ? 2.5 : 0.0, 0.0),
            padding: EdgeInsets.symmetric(
              horizontal: widget.compact ? AppSpacing.sm : AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(AppRadius.input),
              border: Border.all(
                color: down ? widget.accentColor : AppColors.borderStrong,
                width: 1.5,
              ),
              boxShadow: _pressed
                  ? const <BoxShadow>[]
                  : <BoxShadow>[
                      BoxShadow(
                        color: (down ? widget.accentColor : AppColors.shadow)
                            .withValues(alpha: down ? 0.28 : 0.12),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (widget.icon != null) ...<Widget>[
                  Icon(widget.icon, size: 16, color: fgColor),
                  const SizedBox(width: 4),
                ],
                Flexible(
                  child: Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.label.copyWith(
                      color: fgColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
