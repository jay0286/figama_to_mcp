import 'package:flutter/material.dart';
import '../../models/health_stats.dart';
import '../../constants/app_colors.dart';
import 'extended_stat_card.dart';

class ExtendedStatsSection extends StatelessWidget {
  final List<ExtendedHealthStat> stats;
  final Function(ExtendedHealthStat)? onStatTap;

  const ExtendedStatsSection({
    super.key,
    required this.stats,
    this.onStatTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            '오늘의 건강 상태',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppColors.textPrimary,
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
              return ExtendedStatCard(
                stat: stats[index],
                onTap: () => onStatTap?.call(stats[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
