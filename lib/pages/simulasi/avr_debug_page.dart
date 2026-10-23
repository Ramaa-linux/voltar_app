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
/// Menjalankan `assets/hex/blink.hex` lewat [AvrService] lalu menampilkan
/// status pin 13. Halaman sementara untuk verifikasi, bukan alur siswa.
class AvrDebugPage extends StatefulWidget {
  const AvrDebugPage({super.key});

  /// Pin LED bawaan Arduino Uno (PB5).
  static const int watchedPin = 13;

  @override
  State<AvrDebugPage> createState() => _AvrDebugPageState();
}

class _AvrDebugPageState extends State<AvrDebugPage> {
  final AvrService _service = AvrService();
  StreamSubscription<int>? _pinSubscription;
  StreamSubscription<String>? _errorSubscription;

  int _pinValue = 0;
  bool _running = false;
  bool _starting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _pinSubscription = _service
        .watchPin(AvrDebugPage.watchedPin)
        .listen((int value) {
          if (!mounted) {
            return;
          }
          setState(() => _pinValue = value);
        });
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
    _pinSubscription?.cancel();
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
    final bool isHigh = _pinValue == 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Kembali',
          icon: const AppIcon.arrowLeft(color: AppColors.textPrimary),
          onPressed: () => context.canPop()
              ? context.pop()
              : context.go(AppRoutes.simulasi),
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
                  Text('Mesin AVR native', style: AppTypography.label),
                  const Spacer(),
                  VoltChip(
                    label: _running ? 'Berjalan' : 'Berhenti',
                    status: _running
                        ? VoltChipStatus.done
                        : VoltChipStatus.locked,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: Center(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                      vertical: AppSpacing.xxl,
                    ),
                    decoration: BoxDecoration(
                      color: isHigh
                          ? AppColors.successLight
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      border: AppBorders.standard,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        AppIcon(
                          AppIconName.lightbulb,
                          size: AppIconSize.lg,
                          color: isHigh
                              ? AppColors.success
                              : AppColors.textTertiary,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Pin ${AvrDebugPage.watchedPin}: '
                          '${isHigh ? 'HIGH' : 'LOW'}',
                          textAlign: TextAlign.center,
                          style: AppTypography.display.copyWith(
                            color: isHigh
                                ? AppColors.success
                                : AppColors.textSecondary,
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
