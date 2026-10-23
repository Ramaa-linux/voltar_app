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
import 'package:voltar/widgets/volt_button.dart';
import 'package:voltar/widgets/volt_chip.dart';

/// Halaman uji coba mesin AVR native (Fase 5A).
///
/// Semua data pin datang dari [AvrService.watchPin]. Halaman tidak membuat
/// isolate, timer, atau membaca aset hex sendiri.
class AvrDebugPage extends StatefulWidget {
  const AvrDebugPage({super.key});

  /// Pin LED bawaan Arduino Uno (PB5).
  static const int watchedPin = AvrService.blinkPin;

  @override
  State<AvrDebugPage> createState() => _AvrDebugPageState();
}

class _AvrDebugPageState extends State<AvrDebugPage> {
  final AvrService _service = AvrService();
  late final Stream<int> _pinStream = _service.watchPin(
    AvrDebugPage.watchedPin,
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
        title: const Text('Debug AVR'),
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
                  Text('Mesin simulasi', style: AppTypography.heading),
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
                child: Center(
                  child: StreamBuilder<int>(
                    stream: _pinStream,
                    initialData:
                        _service.pinValue(AvrDebugPage.watchedPin) ?? 0,
                    builder:
                        (BuildContext context, AsyncSnapshot<int> snapshot) {
                          return _PinStatusCard(isHigh: snapshot.data == 1);
                        },
                  ),
                ),
              ),
              if (_error != null) ...<Widget>[
                Text(
                  _error!,
                  style: AppTypography.caption.copyWith(color: AppColors.error),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
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

/// Kartu status pin 13. Dipisah supaya pembacaan snapshot tetap ringkas.
class _PinStatusCard extends StatelessWidget {
  const _PinStatusCard({required this.isHigh});

  final bool isHigh;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.xxl,
      ),
      decoration: BoxDecoration(
        color: isHigh ? AppColors.successLight : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: AppBorders.standard,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppIcon(
            AppIconName.lightbulb,
            size: AppIconSize.lg,
            color: isHigh ? AppColors.success : AppColors.textTertiary,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Pin ${AvrDebugPage.watchedPin}: ${isHigh ? 'HIGH' : 'LOW'}',
            textAlign: TextAlign.center,
            style: AppTypography.display.copyWith(
              color: isHigh ? AppColors.success : AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'blink.hex - ATmega328P @16 MHz',
            textAlign: TextAlign.center,
            style: AppTypography.caption,
          ),
        ],
      ),
    );
  }
}
