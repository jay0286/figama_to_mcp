import 'package:flutter/material.dart';
import '../../../../shared/models/calendar_day.dart';
import 'day_column.dart';

class WeekCalendar extends StatelessWidget {
  const WeekCalendar({
    super.key,
    required this.days,
    this.onDateSelect,
  });

  final List<CalendarDay> days;
  final ValueChanged<int>? onDateSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days.map((day) {
        return Flexible(
          child: DayColumn(
            dayName: day.dayName,
            date: day.date,
            isSelected: day.isSelected,
            onTap: () => onDateSelect?.call(day.date),
          ),
        );
      }).toList(),
    );
  }
}
