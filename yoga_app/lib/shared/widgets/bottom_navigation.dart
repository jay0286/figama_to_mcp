import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_images.dart';
import '../../core/theme/app_theme.dart';

enum NavTab { home, classes, diets, profile }

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.activeTab,
    this.onTabChange,
  });

  final NavTab activeTab;
  final ValueChanged<NavTab>? onTabChange;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.surface,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Row(
        children: [
          _NavItem(
            tab: NavTab.home,
            iconPath: AppImages.icHome,
            label: '홈',
            isActive: activeTab == NavTab.home,
            activeColor: colorScheme.primary,
            inactiveColor: colors.textMuted,
            onTap: () => onTabChange?.call(NavTab.home),
          ),
          _NavItem(
            tab: NavTab.classes,
            iconPath: AppImages.icCalendar,
            label: '클래스',
            isActive: activeTab == NavTab.classes,
            activeColor: colorScheme.primary,
            inactiveColor: colors.textMuted,
            onTap: () => onTabChange?.call(NavTab.classes),
          ),
          _NavItem(
            tab: NavTab.diets,
            iconPath: AppImages.icDiet,
            label: '식단',
            isActive: activeTab == NavTab.diets,
            activeColor: colorScheme.primary,
            inactiveColor: colors.textMuted,
            onTap: () => onTabChange?.call(NavTab.diets),
          ),
          _NavItem(
            tab: NavTab.profile,
            iconPath: AppImages.icUser,
            label: '내정보',
            isActive: activeTab == NavTab.profile,
            activeColor: colorScheme.primary,
            inactiveColor: colors.textMuted,
            onTap: () => onTabChange?.call(NavTab.profile),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.tab,
    required this.iconPath,
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    this.onTap,
  });

  final NavTab tab;
  final String iconPath;
  final String label;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 56,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  iconPath,
                  fit: BoxFit.contain,
                  colorFilter: isActive
                      ? null
                      : ColorFilter.mode(inactiveColor, BlendMode.srcIn),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: isActive ? activeColor : inactiveColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
