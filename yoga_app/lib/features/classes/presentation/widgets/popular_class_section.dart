import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/popular_class.dart';
import 'popular_class_card.dart';

class PopularClassSection extends StatelessWidget {
  const PopularClassSection({
    super.key,
    required this.classes,
    this.onClassTap,
    this.onViewAllTap,
  });

  final List<PopularClass> classes;
  final ValueChanged<PopularClass>? onClassTap;
  final VoidCallback? onViewAllTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 14),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '인기요가 클래스',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: colors.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: onViewAllTap,
                  child: Text(
                    '더보기',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 400,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: classes.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final classData = classes[index];
                return PopularClassCard(
                  classData: classData,
                  onTap: () => onClassTap?.call(classData),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
