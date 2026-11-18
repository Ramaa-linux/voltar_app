import 'package:flutter/material.dart';
import '../../../theme/app_borders.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_icon.dart';

/// Floating Action Button dengan menu expandable untuk Guru:
/// - Buat Pengumuman
/// - Buat Tugas
/// 
/// Includes scrim/backdrop for outside-tap close.
class SpeedDialFab extends StatefulWidget {
  final VoidCallback onCreateAnnouncement;
  final VoidCallback onCreateAssignment;

  const SpeedDialFab({
    super.key,
    required this.onCreateAnnouncement,
    required this.onCreateAssignment,
  });

  @override
  State<SpeedDialFab> createState() => _SpeedDialFabState();
}

class _SpeedDialFabState extends State<SpeedDialFab>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _close() {
    if (_isOpen) {
      setState(() {
        _isOpen = false;
        _controller.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Scrim/backdrop - covers entire screen to catch outside taps
        if (_isOpen)
          Positioned.fill(
            child: GestureDetector(
              onTap: _close,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                color: Colors.black.withValues(alpha: 0.3),
              ),
            ),
          ),
        // Speed dial menu
        Positioned(
          right: AppSpacing.pagePadding,
          bottom: AppSpacing.navBarClearance + AppSpacing.md,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (_isOpen) ...[
                FadeTransition(
                  opacity: _animation,
                  child: _SpeedDialOption(
                    label: 'Buat Tugas',
                    icon: AppIconName.fileText,
                    color: AppColors.accent,
                    onTap: () {
                      _close();
                      widget.onCreateAssignment();
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                FadeTransition(
                  opacity: _animation,
                  child: _SpeedDialOption(
                    label: 'Buat Pengumuman',
                    icon: AppIconName.bell,
                    color: AppColors.primary,
                    onTap: () {
                      _close();
                      widget.onCreateAnnouncement();
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              FloatingActionButton(
                onPressed: _toggle,
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.button),
                ),
                child: AnimatedRotation(
                  turns: _isOpen ? 0.125 : 0, // 45 degrees rotation
                  duration: const Duration(milliseconds: 200),
                  child: const AppIcon(
                    AppIconName.plus,
                    size: 24,
                    color: AppColors.textOnPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SpeedDialOption extends StatelessWidget {
  final String label;
  final AppIconName icon;
  final Color color;
  final VoidCallback onTap;

  const _SpeedDialOption({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.button),
      elevation: 4,
      shadowColor: AppColors.shadow.withValues(alpha: 0.15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.button),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: AppIcon(icon, size: 18, color: color),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                label,
                style: AppTypography.button.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
            ],
          ),
        ),
      ),
    );
  }
}