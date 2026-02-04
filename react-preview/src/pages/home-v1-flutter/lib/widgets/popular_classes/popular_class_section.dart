import 'package:flutter/material.dart';
import '../../models/popular_class.dart';
import '../../constants/app_colors.dart';
import 'popular_class_card.dart';

class PopularClassSection extends StatelessWidget {
  final List<PopularClass> classes;
  final Function(PopularClass)? onClassTap;
  final VoidCallback? onViewAllTap;

  const PopularClassSection({
    super.key,
    required this.classes,
    this.onClassTap,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 14),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '인기요가 클래스',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColors.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: onViewAllTap,
                  child: const Text(
                    '더보기',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ...classes.map((classData) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: PopularClassCard(
                  classData: classData,
                  onTap: () => onClassTap?.call(classData),
                ),
              )),
        ],
      ),
    );
  }
}
