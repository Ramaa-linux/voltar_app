import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voltar/theme/app_colors.dart';

/// Ikon Lucide yang dipakai VoltAR (sumber: assets/icons/*.svg, lisensi ISC).
///
/// Semua ikon 24x24, stroke 2, fill none, sehingga aman di-tint lewat
/// [ColorFilter] dan tetap tajam di ukuran berapa pun.
enum AppIconName {
  home,
  bookOpen,
  cpu,
  profile,
  chevronRight,
  bell,
  info,
  pencil,
  zap,
  lightbulb,
  battery,
  plus,
  arrowLeft,
  play,
  stop,
}

/// Ukuran ikon standar - jangan pakai angka lepas di widget.
abstract final class AppIconSize {
  static const double sm = 18;
  static const double md = 22;
  static const double lg = 24;
}

/// Pembungkus [SvgPicture.asset] agar path, ukuran, dan warna konsisten.
///
/// Contoh: `const AppIcon.home(size: AppIconSize.lg, color: AppColors.primary)`.
class AppIcon extends StatelessWidget {
  const AppIcon(
    this.name, {
    super.key,
    this.size = AppIconSize.md,
    this.color = AppColors.textSecondary,
    this.semanticLabel,
  });

  const AppIcon.home({
    super.key,
    this.size = AppIconSize.md,
    this.color = AppColors.textSecondary,
    this.semanticLabel,
  }) : name = AppIconName.home;

  const AppIcon.bookOpen({
    super.key,
    this.size = AppIconSize.md,
    this.color = AppColors.textSecondary,
    this.semanticLabel,
  }) : name = AppIconName.bookOpen;

  const AppIcon.cpu({
    super.key,
    this.size = AppIconSize.md,
    this.color = AppColors.textSecondary,
    this.semanticLabel,
  }) : name = AppIconName.cpu;

  const AppIcon.profile({
    super.key,
    this.size = AppIconSize.md,
    this.color = AppColors.textSecondary,
    this.semanticLabel,
  }) : name = AppIconName.profile;

  const AppIcon.chevronRight({
    super.key,
    this.size = AppIconSize.md,
    this.color = AppColors.textSecondary,
    this.semanticLabel,
  }) : name = AppIconName.chevronRight;

  const AppIcon.bell({
    super.key,
    this.size = AppIconSize.md,
    this.color = AppColors.textSecondary,
    this.semanticLabel,
  }) : name = AppIconName.bell;

  const AppIcon.info({
    super.key,
    this.size = AppIconSize.md,
    this.color = AppColors.textSecondary,
    this.semanticLabel,
  }) : name = AppIconName.info;

  const AppIcon.pencil({
    super.key,
    this.size = AppIconSize.md,
    this.color = AppColors.textSecondary,
    this.semanticLabel,
  }) : name = AppIconName.pencil;

  const AppIcon.zap({
    super.key,
    this.size = AppIconSize.md,
    this.color = AppColors.textSecondary,
    this.semanticLabel,
  }) : name = AppIconName.zap;

  const AppIcon.lightbulb({
    super.key,
    this.size = AppIconSize.md,
    this.color = AppColors.textSecondary,
    this.semanticLabel,
  }) : name = AppIconName.lightbulb;

  const AppIcon.battery({
    super.key,
    this.size = AppIconSize.md,
    this.color = AppColors.textSecondary,
    this.semanticLabel,
  }) : name = AppIconName.battery;

  const AppIcon.plus({
    super.key,
    this.size = AppIconSize.md,
    this.color = AppColors.textSecondary,
    this.semanticLabel,
  }) : name = AppIconName.plus;

  const AppIcon.arrowLeft({
    super.key,
    this.size = AppIconSize.md,
    this.color = AppColors.textSecondary,
    this.semanticLabel,
  }) : name = AppIconName.arrowLeft;

  const AppIcon.play({
    super.key,
    this.size = AppIconSize.md,
    this.color = AppColors.textSecondary,
    this.semanticLabel,
  }) : name = AppIconName.play;

  const AppIcon.stop({
    super.key,
    this.size = AppIconSize.md,
    this.color = AppColors.textSecondary,
    this.semanticLabel,
  }) : name = AppIconName.stop;

  final AppIconName name;
  final double size;
  final Color color;

  /// Diisi hanya bila ikon berdiri sendiri (tanpa label teks di sebelahnya).
  final String? semanticLabel;

  static String _assetFor(AppIconName name) => switch (name) {
    AppIconName.home => 'assets/icons/home.svg',
    AppIconName.bookOpen => 'assets/icons/book-open.svg',
    AppIconName.cpu => 'assets/icons/cpu.svg',
    AppIconName.profile => 'assets/icons/user.svg',
    AppIconName.chevronRight => 'assets/icons/chevron-right.svg',
    AppIconName.bell => 'assets/icons/bell.svg',
    AppIconName.info => 'assets/icons/info.svg',
    AppIconName.pencil => 'assets/icons/pencil.svg',
    AppIconName.zap => 'assets/icons/zap.svg',
    AppIconName.lightbulb => 'assets/icons/lightbulb.svg',
    AppIconName.battery => 'assets/icons/battery.svg',
    AppIconName.plus => 'assets/icons/plus.svg',
    AppIconName.arrowLeft => 'assets/icons/arrow-left.svg',
    AppIconName.play => 'assets/icons/play.svg',
    AppIconName.stop => 'assets/icons/stop.svg',
  };

  @override
  Widget build(BuildContext context) {
    // File Lucide memakai stroke="currentColor"; srcIn menimpa seluruh piksel
    // non-transparan sehingga warna selalu mengikuti token.
    final Widget icon = SvgPicture.asset(
      _assetFor(name),
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );

    final String? label = semanticLabel;
    if (label == null) {
      return ExcludeSemantics(child: icon);
    }
    return Semantics(image: true, label: label, child: icon);
  }
}
