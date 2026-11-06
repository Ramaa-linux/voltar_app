import 'package:flutter/material.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/app_icon.dart';

/// Satu tujuan navigasi pada [VoltFloatingNavBar].
@immutable
class VoltNavItem {
  const VoltNavItem({required this.icon, required this.label});

  final AppIconName icon;
  final String label;
}

/// Navigasi mengambang VoltAR: radius 24, border 1px, shadow lembut.
///
/// Fase 2: murni UI. Tanpa go_router - pemanggil yang mengatur [currentIndex]
/// lewat [onTap]. `onTap == null` membuat seluruh item tidak bisa ditekan.
class VoltFloatingNavBar extends StatelessWidget {
  const VoltFloatingNavBar({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.margin = EdgeInsets.zero,
  });

  final List<VoltNavItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;

  /// Jarak dari tepi layar diatur pemanggil (AppShell di Fase 3).
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.navBar),
          border: AppBorders.standard,
          boxShadow: AppShadows.navBar,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
            children: <Widget>[
              for (int i = 0; i < items.length; i++)
                Expanded(
                  child: _VoltNavItemView(
                    item: items[i],
                    selected: i == currentIndex,
                    onTap: onTap == null ? null : () => onTap!(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VoltNavItemView extends StatelessWidget {
  const _VoltNavItemView({
    required this.item,
    required this.selected,
    this.onTap,
  });

  final VoltNavItem item;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color color = selected
        ? AppColors.primaryDark
        : AppColors.textSecondary;
    final BorderRadius radius = BorderRadius.circular(AppRadius.card);

    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      excludeSemantics: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        constraints: const BoxConstraints(minHeight: AppSpacing.minTouchTarget),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryLight : Colors.transparent,
          borderRadius: radius,
        ),
        // Material transparan: ripple tergambar di atas pill, bukan di bawahnya.
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            borderRadius: radius,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.sm,
                horizontal: AppSpacing.xs,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AppIcon(item.icon, size: AppIconSize.md, color: color),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.overline.copyWith(
                      color: color,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
