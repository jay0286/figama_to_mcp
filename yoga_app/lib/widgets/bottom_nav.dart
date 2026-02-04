import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_images.dart';

enum NavTab { home, classes, diets, profile }

class BottomNav extends StatelessWidget {
  final NavTab activeTab;
  final Function(NavTab)? onTabChange;

  const BottomNav({
    super.key,
    required this.activeTab,
    this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Row(
        children: [
          _buildNavItem(NavTab.home, AppImages.icHome, '홈'),
          _buildNavItem(NavTab.classes, AppImages.icCalendar, '클래스'),
          _buildNavItem(NavTab.diets, AppImages.icDiet, '식단'),
          _buildNavItem(NavTab.profile, AppImages.icUser, '내정보'),
        ],
      ),
    );
  }

  Widget _buildNavItem(NavTab tab, String iconPath, String label) {
    final isActive = activeTab == tab;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChange?.call(tab),
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
                      : const ColorFilter.mode(
                          AppColors.textMuted,
                          BlendMode.srcIn,
                        ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: isActive ? AppColors.primary : AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
