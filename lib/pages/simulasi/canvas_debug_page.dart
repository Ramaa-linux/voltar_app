import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/router/app_routes.dart';
import 'package:voltar/services/avr_service.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/arduino_painter.dart';
import 'package:voltar/widgets/volt_button.dart';
import 'package:voltar/widgets/volt_chip.dart';

/// Halaman uji canvas 2D (Fase 5A Hari 3).
///
/// Status LED hanya berasal dari [AvrService.watchPin]; halaman tidak
/// menghitung nilai pin sendiri dan tidak memegang isolate.
class CanvasDebugPage extends StatefulWidget {
  const CanvasDebugPage({super.key});

  /// Pin LED bawaan Arduino Uno (PB5).
  static const int watchedPin = AvrService.blinkPin;

  @override
  State<CanvasDebugPage> createState() => _CanvasDebugPageState();
}

class _CanvasDebugPageState extends State<CanvasDebugPage> {
  final AvrService _service = AvrService();
  late final Stream<int> _pinStream = _service.watchPin(
    CanvasDebugPage.watchedPin,
  );
  StreamSubscription<String>? _errorSubscription;

  bool _running = false;
  bool _starting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _errorSubscription = _service.errors.listen((String message) {
      if (!mounted) {
        return;
      }
      setState(() {
        _running = false;
        _error = message;
      });
    });
  }

  @override
  void dispose() {
    _errorSubscription?.cancel();
    unawaited(_service.dispose());
    super.dispose();
  }

  Future<void> _start() async {
    if (_starting || _running) {
      return;
    }
    setState(() {
      _starting = true;
      _error = null;
    });
    try {
      await _service.start();
      if (!mounted) {
        return;
      }
      setState(() {
        _starting = false;
        _running = true;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _starting = false;
        _error = 'Gagal memuat simulasi: $error';
      });
    }
  }

  void _stop() {
    _service.stop();
    setState(() => _running = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Kembali',
          icon: const AppIcon.arrowLeft(color: AppColors.textPrimary),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go(AppRoutes.simulasi),
        ),
        title: const Text('Canvas 2D'),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('Rangkaian Blink', style: AppTypography.heading),
                  const Spacer(),
                  VoltChip(
                    label: _running
                        ? (_service.runsInIsolate ? 'Isolate' : 'Timer')
                        : 'Berhenti',
                    status: _running
                        ? VoltChipStatus.done
                        : VoltChipStatus.locked,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    border: AppBorders.standard,
                  ),
                  child: StreamBuilder<int>(
                    stream: _pinStream,
                    initialData:
                        _service.pinValue(CanvasDebugPage.watchedPin) ?? 0,
                    builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                      final bool isHigh = snapshot.data == 1;
                      return Column(
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: AspectRatio(
                                aspectRatio: ArduinoGeometry.canvasAspect,
                                child: RepaintBoundary(
                                  child: Semantics(
                                    label:
                                        'LED pin ${CanvasDebugPage.watchedPin} '
                                        '${isHigh ? 'menyala' : 'mati'}',
                                    child: CustomPaint(
                                      isComplex: true,
                                      willChange: false,
                                      painter: ArduinoPainter(ledOn: isHigh),
                                      child: const SizedBox.expand(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'Pin ${CanvasDebugPage.watchedPin}: '
                            '${isHigh ? 'HIGH' : 'LOW'}',
                            style: AppTypography.label.copyWith(
                              color: isHigh
                                  ? AppColors.error
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              if (_error != null) ...<Widget>[
                const SizedBox(height: AppSpacing.md),
                Text(
                  _error!,
                  style: AppTypography.caption.copyWith(color: AppColors.error),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: <Widget>[
                  Expanded(
                    child: VoltButton(
                      label: 'Start',
                      icon: AppIconName.zap,
                      fullWidth: true,
                      onPressed: (_running || _starting) ? null : _start,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: VoltButton(
                      label: 'Stop',
                      variant: VoltButtonVariant.secondary,
                      fullWidth: true,
                      onPressed: _running ? _stop : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
