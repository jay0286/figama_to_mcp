import 'package:flutter/material.dart';
import '../../models/health_stats.dart';
import 'stat_card.dart';

class QuickStatsRow extends StatelessWidget {
  final HealthStats stats;
  final Function(StatType)? onStatTap;

  const QuickStatsRow({
    super.key,
    required this.stats,
    this.onStatTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          StatCard(
            type: StatType.water,
            label: stats.water.label,
            value: stats.water.value,
            unit: stats.water.unit,
            onTap: () => onStatTap?.call(StatType.water),
          ),
          const SizedBox(width: 8),
          StatCard(
            type: StatType.steps,
            label: stats.steps.label,
            value: stats.steps.value,
            unit: stats.steps.unit,
            onTap: () => onStatTap?.call(StatType.steps),
          ),
          const SizedBox(width: 8),
          StatCard(
            type: StatType.calories,
            label: stats.calories.label,
            value: stats.calories.value,
            unit: stats.calories.unit,
            onTap: () => onStatTap?.call(StatType.calories),
          ),
        ],
      ),
    );
  }
}
