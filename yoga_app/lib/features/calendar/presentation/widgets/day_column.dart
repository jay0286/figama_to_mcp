import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class DayColumn extends StatelessWidget {
  const DayColumn({
    super.key,
    required this.dayName,
    required this.date,
    this.isSelected = false,
    this.onTap,
  });

  final String dayName;
  final int date;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 32, maxWidth: 40),
        child: Column(
          children: [
            Text(
              dayName,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: isSelected ? colorScheme.primary : colors.textMuted,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? colorScheme.primary : Colors.transparent,
                shape: BoxShape.circle,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: colorScheme.primary.withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  date.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color:
                        isSelected ? colorScheme.onPrimary : colors.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
