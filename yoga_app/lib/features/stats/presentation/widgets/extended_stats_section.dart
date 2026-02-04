import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/health_stats.dart';
import 'extended_stat_card.dart';

class ExtendedStatsSection extends StatelessWidget {
  const ExtendedStatsSection({
    super.key,
    required this.stats,
    this.onStatTap,
  });

  final List<ExtendedHealthStat> stats;
  final ValueChanged<ExtendedHealthStat>? onStatTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            '오늘의 건강 상태',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: colors.textPrimary,
            ),
          ),
        ),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: stats.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final stat = stats[index];
              return ExtendedStatCard(
                stat: stat,
                onTap: () => onStatTap?.call(stat),
              );
            },
          ),
        ),
      ],
    );
  }
}
