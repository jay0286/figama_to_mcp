class HealthStat {
  final String label;
  final String value;
  final String unit;
  final String? icon;

  HealthStat({
    required this.label,
    required this.value,
    required this.unit,
    this.icon,
  });
}

class HealthStats {
  final HealthStat water;
  final HealthStat steps;
  final HealthStat calories;

  HealthStats({
    required this.water,
    required this.steps,
    required this.calories,
  });
}

// 확장된 건강 상태 모델
class ExtendedHealthStat {
  final int id;
  final String label;
  final String value;
  final String unit;
  final String type; // water, steps, calories, weight, sleep, heart
  final String? date;

  ExtendedHealthStat({
    required this.id,
    required this.label,
    required this.value,
    required this.unit,
    required this.type,
    this.date,
  });
}
