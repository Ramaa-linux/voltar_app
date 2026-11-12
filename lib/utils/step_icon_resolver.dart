import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voltar/models/learning_step.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/widgets/app_icon.dart';

/// Spesifikasi ikon [LearningStep]: path SVG kustom (opsional) + fallback [AppIconName].
@immutable
class StepIconSpec {
  const StepIconSpec({
    required this.fallbackIcon,
    this.svgAsset,
  });

  final String? svgAsset;
  final AppIconName fallbackIcon;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepIconSpec &&
          svgAsset == other.svgAsset &&
          fallbackIcon == other.fallbackIcon;

  @override
  int get hashCode => Object.hash(svgAsset, fallbackIcon);
}

final List<(RegExp, StepIconSpec)> _materiIconRules = <(RegExp, StepIconSpec)>[
  (
    RegExp(r'\bresistor\b', caseSensitive: false),
    const StepIconSpec(
      svgAsset: 'assets/icons/components/resistor.svg',
      fallbackIcon: AppIconName.zap,
    ),
  ),
  (
    RegExp(r'\b(led|light\s+emitting\s+diode|dioda)\b', caseSensitive: false),
    const StepIconSpec(
      svgAsset: 'assets/icons/components/led.svg',
      fallbackIcon: AppIconName.lightbulb,
    ),
  ),
  (
    RegExp(r'\b(kapasitor|capacitor|baterai|battery)\b', caseSensitive: false),
    const StepIconSpec(
      svgAsset: 'assets/icons/components/capacitor.svg',
      fallbackIcon: AppIconName.battery,
    ),
  ),
  (
    RegExp(r'\b(breadboard|rangkaian|board|arduino|mikrokontroler)\b', caseSensitive: false),
    const StepIconSpec(
      svgAsset: 'assets/icons/components/breadboard.svg',
      fallbackIcon: AppIconName.cpu,
    ),
  ),
  (
    RegExp(r'\b(switch|push\s*button|tactile|tombol|debouncing)\b', caseSensitive: false),
    const StepIconSpec(
      svgAsset: 'assets/icons/components/switch.svg',
      fallbackIcon: AppIconName.play,
    ),
  ),
  (
    RegExp(r'\b(ohm|tegangan|arus|listrik)\b', caseSensitive: false),
    const StepIconSpec(
      svgAsset: 'assets/icons/components/ohm.svg',
      fallbackIcon: AppIconName.zap,
    ),
  ),
  (
    RegExp(r'\brelay\b', caseSensitive: false),
    const StepIconSpec(
      svgAsset: 'assets/icons/components/relay.svg',
      fallbackIcon: AppIconName.zap,
    ),
  ),
  (
    RegExp(r'\b(sensor|adc|ultrasonik|ldr)\b', caseSensitive: false),
    const StepIconSpec(
      svgAsset: 'assets/icons/components/sensor.svg',
      fallbackIcon: AppIconName.cpu,
    ),
  ),
  (
    RegExp(r'\b(motor|servo|stepper)\b', caseSensitive: false),
    const StepIconSpec(
      svgAsset: 'assets/icons/components/motor.svg',
      fallbackIcon: AppIconName.cpu,
    ),
  ),
  (
    RegExp(r'\b(pwm|interrupt)\b', caseSensitive: false),
    const StepIconSpec(
      svgAsset: 'assets/icons/components/pwm.svg',
      fallbackIcon: AppIconName.zap,
    ),
  ),
  (
    RegExp(r'\b(sketch|array|pointer|variabel|kode|program)\b', caseSensitive: false),
    const StepIconSpec(
      svgAsset: 'assets/icons/components/code.svg',
      fallbackIcon: AppIconName.fileText,
    ),
  ),
];

/// Menentukan [StepIconSpec] secara dinamis berdasarkan tipe, ID, dan judul [step].
StepIconSpec resolveStepIcon(LearningStep step) => switch (step.type) {
  LearningStepType.pretest => const StepIconSpec(fallbackIcon: AppIconName.helpCircle),
  LearningStepType.posttest => const StepIconSpec(fallbackIcon: AppIconName.checkSquare),
  LearningStepType.folder => const StepIconSpec(fallbackIcon: AppIconName.folder),
  LearningStepType.materi => resolveMateriIcon(title: step.title, id: step.id),
};

/// Menentukan [StepIconSpec] khusus materi dari [title] dan opsional [id].
StepIconSpec resolveMateriIcon({required String title, String id = ''}) {
  final String normalizedId = id.replaceAll('_', ' ');
  if (normalizedId.isNotEmpty) {
    for (final (RegExp pattern, StepIconSpec spec) in _materiIconRules) {
      if (pattern.hasMatch(normalizedId)) return spec;
    }
  }
  for (final (RegExp pattern, StepIconSpec spec) in _materiIconRules) {
    if (pattern.hasMatch(title)) return spec;
  }
  return const StepIconSpec(fallbackIcon: AppIconName.bookOpen);
}

/// Widget ikon materi dengan dukungan SVG komponen kustom dan fallback [AppIcon].
class StepIcon extends StatefulWidget {
  const StepIcon({
    super.key,
    required this.step,
    this.size = AppIconSize.md,
    this.color = AppColors.primaryDark,
  });

  final LearningStep step;
  final double size;
  final Color color;

  @override
  State<StepIcon> createState() => _StepIconState();
}

class _StepIconState extends State<StepIcon> {
  static final Map<String, String?> _svgCache = <String, String?>{};
  String? _loadedSvg;

  @override
  void initState() {
    super.initState();
    _loadCustomSvgIfAny();
  }

  @override
  void didUpdateWidget(covariant StepIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.step.id != widget.step.id ||
        oldWidget.step.title != widget.step.title ||
        oldWidget.step.type != widget.step.type) {
      _loadCustomSvgIfAny();
    }
  }

  void _loadCustomSvgIfAny() {
    final String? assetPath = resolveStepIcon(widget.step).svgAsset;
    if (assetPath == null) {
      _loadedSvg = null;
      return;
    }
    if (_svgCache.containsKey(assetPath)) {
      _loadedSvg = _svgCache[assetPath];
      return;
    }
    rootBundle.loadString(assetPath).then<void>(
      (String content) {
        _svgCache[assetPath] = content;
        if (mounted) setState(() => _loadedSvg = content);
      },
      onError: (Object _) {
        _svgCache[assetPath] = null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final StepIconSpec spec = resolveStepIcon(widget.step);
    final String? svgData = _loadedSvg;
    if (svgData != null && svgData.isNotEmpty) {
      return ExcludeSemantics(
        child: SvgPicture.string(
          svgData,
          width: widget.size,
          height: widget.size,
          colorFilter: ColorFilter.mode(widget.color, BlendMode.srcIn),
        ),
      );
    }
    return AppIcon(spec.fallbackIcon, size: widget.size, color: widget.color);
  }
}

