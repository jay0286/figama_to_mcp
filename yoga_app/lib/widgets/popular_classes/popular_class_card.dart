import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/popular_class.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';

class PopularClassCard extends StatelessWidget {
  final PopularClass classData;
  final VoidCallback? onTap;

  const PopularClassCard({
    super.key,
    required this.classData,
    this.onTap,
  });

  Color get _categoryBgColor {
    switch (classData.category) {
      case ClassCategory.popular:
        return AppColors.popularBg;
      case ClassCategory.beginner:
        return AppColors.beginnerBg;
      case ClassCategory.therapy:
        return AppColors.therapyBg;
    }
  }

  Color get _categoryTextColor {
    switch (classData.category) {
      case ClassCategory.popular:
        return AppColors.popularText;
      case ClassCategory.beginner:
        return AppColors.beginnerText;
      case ClassCategory.therapy:
        return AppColors.therapyText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                classData.image,
                width: 96,
                height: 96,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: _categoryBgColor,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Center(
                      widthFactor: 1,
                      child: Text(
                        classData.categoryLabel,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: _categoryTextColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    classData.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: SvgPicture.asset(
                          AppImages.icTime,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        classData.time,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    classData.instructor,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
