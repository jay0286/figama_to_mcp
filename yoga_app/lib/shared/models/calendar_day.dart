import 'package:flutter/foundation.dart';

@immutable
class CalendarDay {
  const CalendarDay({
    required this.dayName,
    required this.date,
    this.isSelected = false,
  });

  final String dayName;
  final int date;
  final bool isSelected;

  CalendarDay copyWith({
    String? dayName,
    int? date,
    bool? isSelected,
  }) {
    return CalendarDay(
      dayName: dayName ?? this.dayName,
      date: date ?? this.date,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CalendarDay &&
        other.dayName == dayName &&
        other.date == date &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode => Object.hash(dayName, date, isSelected);

  @override
  String toString() =>
      'CalendarDay(dayName: $dayName, date: $date, isSelected: $isSelected)';
}
