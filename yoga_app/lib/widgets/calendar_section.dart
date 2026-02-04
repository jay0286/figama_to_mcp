import 'package:flutter/material.dart';
import '../models/calendar_day.dart';
import '../models/booked_class.dart';
import '../constants/app_colors.dart';
import 'calendar/week_calendar.dart';
import 'booked_classes/booked_class_list.dart';

class CalendarSection extends StatelessWidget {
  final List<CalendarDay> calendarDays;
  final List<BookedClass> bookedClasses;
  final Function(int)? onDateSelect;
  final Function(BookedClass)? onClassTap;

  const CalendarSection({
    super.key,
    required this.calendarDays,
    required this.bookedClasses,
    this.onDateSelect,
    this.onClassTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
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
                      const Expanded(
                        child: Text(
                          '예약된 클래스',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          '전체보기',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppColors.textMuted,
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
