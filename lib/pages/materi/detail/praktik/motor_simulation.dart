import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/motor_sim_controller.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/painters/dc_motor_painter.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/painters/servo_painter.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/painters/stepper_painter.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/widgets/code_preview_card.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/widgets/dc_controls.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/widgets/input_selector.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/widgets/servo_controls.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/widgets/stepper_controls.dart';
import 'package:voltar/pages/materi/detail/praktik/motor/widgets/telemetry_panel.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/volt_card.dart';

/// Simulasi Interaktif Fase 10D (`l4_jenis_motor`):
/// 1. Servo SG90 (PWM 50 Hz, 500–2400 µs, 0–180°)
/// 2. Motor DC (PWM 0–255, dead-zone < 40, inersia & balik arah mulus)
/// 3. Stepper 28BYJ-48 + ULN2003 (diskrit 5.625°/step, rasio 1:64, 4 kumparan ABCD)
class MotorSimulation extends StatefulWidget {
  const MotorSimulation({super.key});

  @override
  State<MotorSimulation> createState() => _MotorSimulationState();
}

class _MotorSimulationState extends State<MotorSimulation>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final MotorSimController _controller;
  late final Ticker _ticker;
  Duration _lastElapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = MotorSimController();
    _ticker = createTicker(_onTick)..start();
  }

  void _onTick(Duration elapsed) {
    final Duration dt =
        _lastElapsed == Duration.zero ? const Duration(milliseconds: 16) : elapsed - _lastElapsed;
    _lastElapsed = elapsed;
    final bool disableAnim =
        mounted && (MediaQuery.maybeOf(context)?.disableAnimations ?? false);
    _controller.tick(dt, instant: disableAnim);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden) {
      _controller.stopAllHolds();
      if (_ticker.isActive) _ticker.stop();
    } else if (state == AppLifecycleState.resumed) {
      if (!_ticker.isActive) {
        _lastElapsed = Duration.zero;
        _ticker.start();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _ticker.dispose();
    _controller.dispose();
    super.dispose();
  }

  Color _accentFor(MotorType type) => switch (type) {
        MotorType.servo => MotorPalette.servoBlue,
        MotorType.dc => AppColors.primary,
        MotorType.stepper => MotorPalette.stepperGreenDark,
      };

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (BuildContext context, _) {
        final Color accent = _accentFor(_controller.motorType);
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.pagePadding),
          child: VoltCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildMotorTabBar(accent),
                const SizedBox(height: AppSpacing.md),
                _buildHeaderBadge(accent),
                const SizedBox(height: AppSpacing.sm),
                _buildWorkbenchCanvas(),
                const SizedBox(height: AppSpacing.md),
                InputSelector(
                  selectedDevice: _controller.inputDevice,
                  onChanged: _controller.setInputDevice,
                  accentColor: accent,
                ),
                const SizedBox(height: AppSpacing.md),
                switch (_controller.motorType) {
                  MotorType.servo => ServoControls(controller: _controller),
                  MotorType.dc => DcControls(controller: _controller),
                  MotorType.stepper => StepperControls(controller: _controller),
                },
                const SizedBox(height: AppSpacing.md),
                TelemetryPanel(controller: _controller),
                const SizedBox(height: AppSpacing.sm),
                CodePreviewCard(controller: _controller),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMotorTabBar(Color activeAccent) {
    const List<(MotorType, String, IconData)> tabs = <(MotorType, String, IconData)>[
      (MotorType.servo, 'Servo', Icons.precision_manufacturing_rounded),
      (MotorType.dc, 'Motor DC', Icons.cyclone_rounded),
      (MotorType.stepper, 'Stepper', Icons.rotate_right_rounded),
    ];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.button),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: <Widget>[
          for (final (MotorType type, String label, IconData icon) in tabs)
            Expanded(
              child: GestureDetector(
                key: Key('motor_tab_${type.name}'),
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  HapticFeedback.selectionClick();
                  _controller.setMotorType(type);
                },
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: AppSpacing.minTouchTarget),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                    decoration: BoxDecoration(
                      color: _controller.motorType == type
                          ? _accentFor(type)
                          : AppColors.surface.withValues(alpha: 0.0),
                      borderRadius: BorderRadius.circular(AppRadius.input),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          icon,
                          size: 16,
                          color: _controller.motorType == type
                              ? AppColors.textOnPrimary
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            label,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.label.copyWith(
                              color: _controller.motorType == type
                                  ? AppColors.textOnPrimary
                                  : AppColors.textSecondary,
                              fontWeight: _controller.motorType == type
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeaderBadge(Color accent) {
    final (String title, String statusText) = switch (_controller.motorType) {
      MotorType.servo => (
          'Simulasi Motor Servo SG90',
          'Sudut: ${_controller.servoCurrentAngle.round()}° | Target: ${_controller.servoTargetAngle.round()}° (${_controller.servoPulseWidthUs} µs)',
        ),
      MotorType.dc => (
          'Simulasi Motor DC & Kontrol PWM',
          'PWM: ${_controller.dcTargetPwm} (${_controller.dcDutyCyclePercent}%) | ${_controller.dcRpm} RPM',
        ),
      MotorType.stepper => (
          'Simulasi Stepper 28BYJ-48 + ULN2003',
          'Step: ${_controller.stepperStepCounter} | Sudut: ${_controller.stepperCurrentAngleDeg.toStringAsFixed(1)}°',
        ),
    };

    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: <Widget>[
        Text(
          title,
          style: AppTypography.title.copyWith(color: AppColors.textPrimary),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: accent.withValues(alpha: 0.4)),
          ),
          child: Text(
            statusText,
            style: AppTypography.overline.copyWith(
              color: accent,
              fontWeight: FontWeight.w700,
              fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWorkbenchCanvas() {
    return RepaintBoundary(
      child: Container(
        height: 224,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[MotorPalette.benchDarkTop, MotorPalette.benchDarkBottom],
          ),
          borderRadius: BorderRadius.circular(AppRadius.button),
          border: Border.all(color: MotorPalette.benchGrid, width: 1.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.button),
          child: CustomPaint(
            painter: const _WorkbenchGridPainter(),
            foregroundPainter: switch (_controller.motorType) {
              MotorType.servo => ServoPainter(
                  currentAngleDeg: _controller.servoCurrentAngle,
                  targetAngleDeg: _controller.servoTargetAngle,
                  pulseWidthUs: _controller.servoPulseWidthUs,
                ),
              MotorType.dc => DcMotorPainter(
                  rotationRad: _controller.dcRotationRad,
                  actualSpeedPwm: _controller.dcActualSpeed,
                  actualDirection: _controller.dcActualDirection,
                  attachment: _controller.dcAttachment,
                  isStalled: _controller.isDcStalled,
                ),
              MotorType.stepper => StepperPainter(
                  visualAngleDeg: _controller.stepperVisualAngleDeg,
                  targetAngleDeg: _controller.stepperTargetAngleDeg,
                  activeCoils: _controller.stepperActiveCoils,
                  stepCounter: _controller.stepperStepCounter,
                ),
            },
            child: const SizedBox.expand(),
          ),
        ),
      ),
    );
  }
}

class _WorkbenchGridPainter extends CustomPainter {
  const _WorkbenchGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint dotPaint = Paint()
      ..color = MotorPalette.benchGrid.withValues(alpha: 0.65)
      ..style = PaintingStyle.fill;
    const double spacing = 18.0;
    for (double x = spacing; x < size.width; x += spacing) {
      for (double y = spacing; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.0, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _WorkbenchGridPainter oldDelegate) => false;
}
