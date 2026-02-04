class CalendarDay {
  final String dayName;
  final int date;
  final bool isSelected;

  CalendarDay({
    required this.dayName,
    required this.date,
    this.isSelected = false,
  });

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
}
