import 'package:flutter/material.dart';
import '../../models/calendar_day.dart';
import 'day_column.dart';

class WeekCalendar extends StatelessWidget {
  final List<CalendarDay> days;
  final Function(int)? onDateSelect;

  const WeekCalendar({
    super.key,
    required this.days,
    this.onDateSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days.map((day) {
        return DayColumn(
          dayName: day.dayName,
          date: day.date,
          isSelected: day.isSelected,
          onTap: () => onDateSelect?.call(day.date),
        );
      }).toList(),
    );
  }
}
