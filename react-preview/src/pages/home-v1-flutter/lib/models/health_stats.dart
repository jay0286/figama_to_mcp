class HealthStat {
  final String label;
  final String value;
  final String unit;

  HealthStat({
    required this.label,
    required this.value,
    required this.unit,
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
