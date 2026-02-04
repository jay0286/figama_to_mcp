import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/health_stats.dart';

class ExtendedStatCard extends StatelessWidget {
  const ExtendedStatCard({
    super.key,
    required this.stat,
    this.onTap,
  });

  final ExtendedHealthStat stat;
  final VoidCallback? onTap;

  String get _iconPath {
    return switch (stat.type) {
      'water' => AppImages.icWater,
      'steps' => AppImages.icSteps,
      'calories' => AppImages.icCalories,
      _ => AppImages.icCalories,
    };
  }

  IconData get _icon {
    return switch (stat.type) {
      'water' => Icons.water_drop_outlined,
      'steps' => Icons.directions_walk,
      'calories' => Icons.local_fire_department_outlined,
      'weight' => Icons.monitor_weight_outlined,
      'sleep' => Icons.bedtime_outlined,
      'heart' => Icons.favorite_outline,
      'fat' => Icons.pie_chart_outline,
      'muscle' => Icons.fitness_center,
      'stress' => Icons.psychology_outlined,
      'meditation' => Icons.self_improvement,
      _ => Icons.analytics_outlined,
    };
  }

  bool get _useSvgIcon {
    return ['water', 'steps', 'calories'].contains(stat.type);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surface,
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
                    color: colorScheme.primary,
                  ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    stat.label,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                      color: colorScheme.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              stat.value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: colors.textDark,
              ),
            ),
            if (stat.unit.isNotEmpty)
              Text(
                stat.unit,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: colors.textMuted,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
