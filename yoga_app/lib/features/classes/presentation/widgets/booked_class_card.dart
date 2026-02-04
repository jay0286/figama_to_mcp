import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/booked_class.dart';

class BookedClassCard extends StatelessWidget {
  const BookedClassCard({
    super.key,
    required this.classData,
    this.onTap,
  });

  final BookedClass classData;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 143,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: classData.bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorScheme.surface,
                      width: 1,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      classData.instructorImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 12,
                        height: 12,
                        child: SvgPicture.asset(
                          AppImages.icRate,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        classData.rating.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: colors.textSecondary,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              classData.instructor,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              classData.className,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              classData.time,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 11,
                color: colors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
