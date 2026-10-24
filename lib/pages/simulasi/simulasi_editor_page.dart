import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/router/app_routes.dart';
import 'package:voltar/services/avr_service.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/utils/volt_feedback.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/arduino_painter.dart';
import 'package:voltar/widgets/grid_background_painter.dart';
import 'package:voltar/widgets/volt_button.dart';
import 'package:voltar/widgets/volt_chip.dart';

/// Sketch Blink LED yang ditampilkan di panel kode.
///
/// Teks masih contoh: yang benar-benar dijalankan mesin AVR adalah
/// `assets/hex/blink.hex`, karena kompilasi sketch masuk Fase 6.
const String blinkSketch = '''
// Blink LED - pin 13 (PB5)
const uint8_t LED = 13;

void setup() {
  pinMode(LED, OUTPUT);
}

void loop() {
  digitalWrite(LED, HIGH);  // LED menyala
  delay(1000);
  digitalWrite(LED, LOW);   // LED mati
  delay(1000);
}
''';

/// Editor simulasi: kanvas rangkaian Arduino + panel kode, layar penuh.
///
/// Route ini berada di atas AppShell (`parentNavigatorKey` root), jadi
/// VoltFloatingNavBar tidak tampil dan halaman wajib menyediakan tombol
/// kembali sendiri. Status LED hanya berasal dari [AvrService.watchPin] -
/// halaman tidak menghitung nilai pin sendiri dan tidak memegang isolate.
class SimulasiEditorPage extends StatefulWidget {
  const SimulasiEditorPage({
    super.key,
    required this.projectName,
    this.isTemplate = false,
  });

  /// Judul default saat project dibuat dari tombol "Buat Project Baru".
  static const String defaultProjectName = 'Project Baru';

  /// Pin LED bawaan Arduino Uno (PB5).
  static const int watchedPin = AvrService.blinkPin;

  final String projectName;

  /// True bila halaman dibuka dari salah satu template bawaan.
  final bool isTemplate;

  @override
  State<SimulasiEditorPage> createState() => _SimulasiEditorPageState();
}

class _SimulasiEditorPageState extends State<SimulasiEditorPage> {
  final AvrService _service = AvrService();
  late final Stream<int> _pinStream = _service.watchPin(
    SimulasiEditorPage.watchedPin,
  );
  final TextEditingController _codeController = TextEditingController(
    text: blinkSketch,
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
        _starting = false;
        _error = message;
      });
      showVoltSnackBar(context, 'Simulasi berhenti: $message');
    });
  }

  @override
  void dispose() {
    _errorSubscription?.cancel();
    _codeController.dispose();
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

  /// Hentikan mesin tanpa menyentuh UI bila halaman sudah dilepas.
  ///
  /// Dipanggil sebelum pop/kembali supaya isolate tidak terus berjalan di
  /// belakang saat pengguna kembali ke dashboard.
  void _haltEngine() {
    _service.stop();
    if (!mounted) {
      return;
    }
    setState(() {
      _running = false;
      _starting = false;
    });
  }

  void _close() {
    _haltEngine();
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go(AppRoutes.simulasi);
  }

  /// Simpan dummy Fase 6: konfirmasi lalu kembali ke dashboard simulasi.
  Future<void> _save() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        title: const Text(
          'Project berhasil disimpan!',
          style: AppTypography.title,
        ),
        content: Text(
          '${widget.projectName} tersimpan di perangkat ini.',
          style: AppTypography.body,
        ),
        actions: <Widget>[
          VoltButton(
            label: 'OK',
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
        ],
      ),
    );
    if (!mounted) {
      return;
    }
    _haltEngine();
    context.go(AppRoutes.simulasi);
  }

  String get _runtimeLabel {
    if (_starting) {
      return 'Memuat';
    }
    if (!_running) {
      return 'Berhenti';
    }
    return _service.runsInIsolate ? 'Isolat' : 'Timer';
  }

  VoltChipStatus get _runtimeStatus {
    if (_starting || _running) {
      return VoltChipStatus.active;
    }
    return VoltChipStatus.locked;
  }

  @override
  Widget build(BuildContext context) {
    // PopScope: back HP/gesture juga menghentikan mesin, bukan hanya tombol
    // kembali di AppBar.
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) {
          _haltEngine();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            tooltip: 'Kembali',
            icon: const AppIcon.arrowLeft(color: AppColors.textPrimary),
            onPressed: _close,
          ),
          title: Text(
            widget.projectName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          actions: <Widget>[
            IconButton(
              tooltip: 'Run',
              onPressed: (_running || _starting) ? null : _start,
              icon: AppIcon.play(
                color: (_running || _starting)
                    ? AppColors.textTertiary
                    : AppColors.primaryDark,
              ),
            ),
            IconButton(
              tooltip: 'Stop',
              onPressed: _running ? _stop : null,
              icon: AppIcon.stop(
                color: _running ? AppColors.error : AppColors.textTertiary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: TextButton(onPressed: _save, child: const Text('Simpan')),
            ),
          ],
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: <Widget>[
              Expanded(flex: 5, child: _buildCircuitPanel()),
              Expanded(flex: 6, child: _buildCodePanel()),
            ],
          ),
        ),
      ),
    );
  }

  /// Panel atas: rangkaian Arduino + status pin dari mesin AVR.
  Widget _buildCircuitPanel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pagePadding,
        AppSpacing.md,
        AppSpacing.pagePadding,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                widget.isTemplate ? 'Template bawaan' : 'Project baru',
                style: AppTypography.label,
              ),
              const Spacer(),
              VoltChip(label: widget.isTemplate ? 'Template' : 'Draft'),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.card),
                border: AppBorders.standard,
              ),
              child: CustomPaint(
                painter: const GridBackgroundPainter(),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: StreamBuilder<int>(
                    stream: _pinStream,
                    initialData:
                        _service.pinValue(SimulasiEditorPage.watchedPin) ?? 0,
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
                                        'LED pin ${SimulasiEditorPage.watchedPin} '
                                        '${isHigh ? 'menyala' : 'mati'}',
                                    child: CustomPaint(
                                      isComplex: true,
                                      willChange: true,
                                      painter: ArduinoPainter(ledOn: isHigh),
                                      child: const SizedBox.expand(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Row(
                            children: <Widget>[
                              if (_starting) ...<Widget>[
                                const SizedBox(
                                  width: AppIconSize.sm,
                                  height: AppIconSize.sm,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                              ],
                              VoltChip(
                                label: _runtimeLabel,
                                status: _runtimeStatus,
                              ),
                              const Spacer(),
                              Text(
                                'Pin ${SimulasiEditorPage.watchedPin}: '
                                '${isHigh ? 'HIGH' : 'LOW'}',
                                style: AppTypography.label.copyWith(
                                  color: isHigh
                                      ? AppColors.error
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          if (_error != null) ...<Widget>[
                            const SizedBox(height: AppSpacing.sm),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _error!,
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.error,
                                ),
                              ),
                            ),
                          ],
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Panel bawah: kotak kode gelap dengan sketch Blink LED.
  Widget _buildCodePanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        color: AppColors.codeBackground,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.card),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const AppIcon.cpu(
                size: AppIconSize.sm,
                color: AppColors.primaryLight,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'blink.ino',
                style: AppTypography.label.copyWith(
                  color: AppColors.primaryLight,
                ),
              ),
              const Spacer(),
              Text(
                'Sketch contoh',
                style: AppTypography.overline.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: TextField(
              controller: _codeController,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.multiline,
              cursorColor: AppColors.primary,
              style: AppTypography.body.copyWith(
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.6,
                color: AppColors.codeText,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
                isCollapsed: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
