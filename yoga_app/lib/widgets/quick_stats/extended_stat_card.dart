import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../models/health_stats.dart';

class ExtendedStatCard extends StatelessWidget {
  final ExtendedHealthStat stat;
  final VoidCallback? onTap;

  const ExtendedStatCard({
    super.key,
    required this.stat,
    this.onTap,
  });

  String get _iconPath {
    switch (stat.type) {
      case 'water':
        return AppImages.icWater;
      case 'steps':
        return AppImages.icSteps;
      case 'calories':
        return AppImages.icCalories;
      default:
        return AppImages.icCalories;
    }
  }

  IconData get _icon {
    switch (stat.type) {
      case 'water':
        return Icons.water_drop_outlined;
      case 'steps':
        return Icons.directions_walk;
      case 'calories':
        return Icons.local_fire_department_outlined;
      case 'weight':
        return Icons.monitor_weight_outlined;
      case 'sleep':
        return Icons.bedtime_outlined;
      case 'heart':
        return Icons.favorite_outline;
      case 'fat':
        return Icons.pie_chart_outline;
      case 'muscle':
        return Icons.fitness_center;
      case 'stress':
        return Icons.psychology_outlined;
      case 'meditation':
        return Icons.self_improvement;
      default:
        return Icons.analytics_outlined;
    }
  }

  bool get _useSvgIcon {
    return ['water', 'steps', 'calories'].contains(stat.type);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (_useSvgIcon)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: SvgPicture.asset(
                      _iconPath,
                      fit: BoxFit.contain,
                    ),
                  )
                else
                  Icon(
                    _icon,
                    size: 16,
                    color: AppColors.primary,
                  ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    stat.label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                      color: AppColors.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              stat.value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColors.textDark,
              ),
            ),
            if (stat.unit.isNotEmpty)
              Text(
                stat.unit,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: AppColors.textMuted,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
