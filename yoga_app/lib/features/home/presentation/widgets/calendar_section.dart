import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/models.dart';
import '../../../calendar/presentation/widgets/week_calendar.dart';
import '../../../classes/presentation/widgets/booked_class_list.dart';

class CalendarSection extends StatelessWidget {
  const CalendarSection({
    super.key,
    required this.calendarDays,
    required this.bookedClasses,
    this.onDateSelect,
    this.onClassTap,
  });

  final List<CalendarDay> calendarDays;
  final List<BookedClass> bookedClasses;
  final ValueChanged<int>? onDateSelect;
  final ValueChanged<BookedClass>? onClassTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            WeekCalendar(
              days: calendarDays,
              onDateSelect: onDateSelect,
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '예약된 클래스',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: colors.textPrimary,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          '전체보기',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: colors.textMuted,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                BookedClassList(
                  classes: bookedClasses,
                  onClassTap: onClassTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
