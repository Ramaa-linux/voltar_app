import 'package:flutter/material.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_typography.dart';

class GuessTimerRing extends StatefulWidget {
  const GuessTimerRing({
    super.key,
    required this.duration,
    required this.isPaused,
    required this.onTimeout,
    this.size = 44.0,
  });

  final Duration duration;
  final bool isPaused;
  final VoidCallback onTimeout;
  final double size;

  @override
  State<GuessTimerRing> createState() => _GuessTimerRingState();
}

class _GuessTimerRingState extends State<GuessTimerRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addStatusListener(_onStatusChanged);
    if (!widget.isPaused) _controller.forward();
  }

  @override
  void didUpdateWidget(covariant GuessTimerRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPaused != oldWidget.isPaused) {
      if (widget.isPaused) {
        _controller.stop(canceled: false);
      } else if (_controller.status != AnimationStatus.completed) {
        _controller.forward();
      }
    }
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
      _controller.reset();
      if (!widget.isPaused) _controller.forward();
    }
  }

  void _onStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) widget.onTimeout();
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_onStatusChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        final double progress = 1.0 - _controller.value;
        final int secondsLeft =
            (widget.duration.inMilliseconds * progress / 1000).ceil();
        final Color color = progress > 0.4
            ? AppColors.primary
            : progress > 0.2
                ? AppColors.accent
                : AppColors.error;

        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                value: progress,
                strokeWidth: 3.5,
                backgroundColor: AppColors.surface.withValues(alpha: 0.16),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
              Text(
                '$secondsLeft',
                style: AppTypography.label.copyWith(
                  color: AppColors.surface,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
