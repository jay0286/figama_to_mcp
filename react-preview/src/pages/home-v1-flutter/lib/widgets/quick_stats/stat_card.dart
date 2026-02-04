import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';

enum StatType { water, steps, calories }

class StatCard extends StatelessWidget {
  final StatType type;
  final String label;
  final String value;
  final String unit;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.type,
    required this.label,
    required this.value,
    required this.unit,
    this.onTap,
  });

  String get _iconUrl {
    switch (type) {
      case StatType.water:
        return AppImages.icWater;
      case StatType.steps:
        return AppImages.icSteps;
      case StatType.calories:
        return AppImages.icCalories;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: Image.network(
                      _iconUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 24,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: value,
                        style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.textDark,
                        ),
                      ),
                      if (unit.isNotEmpty)
                        TextSpan(
                          text: unit,
                          style: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: AppColors.textDark,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
