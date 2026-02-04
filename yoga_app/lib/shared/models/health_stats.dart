import 'package:flutter/foundation.dart';

@immutable
class HealthStat {
  const HealthStat({
    required this.label,
    required this.value,
    required this.unit,
    this.icon,
  });

  final String label;
  final String value;
  final String unit;
  final String? icon;

  HealthStat copyWith({
    String? label,
    String? value,
    String? unit,
    String? icon,
  }) {
    return HealthStat(
      label: label ?? this.label,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      icon: icon ?? this.icon,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HealthStat &&
        other.label == label &&
        other.value == value &&
        other.unit == unit &&
        other.icon == icon;
  }

  @override
  int get hashCode => Object.hash(label, value, unit, icon);
}

@immutable
class HealthStats {
  const HealthStats({
    required this.water,
    required this.steps,
    required this.calories,
  });

  final HealthStat water;
  final HealthStat steps;
  final HealthStat calories;

  HealthStats copyWith({
    HealthStat? water,
    HealthStat? steps,
    HealthStat? calories,
  }) {
    return HealthStats(
      water: water ?? this.water,
      steps: steps ?? this.steps,
      calories: calories ?? this.calories,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HealthStats &&
        other.water == water &&
        other.steps == steps &&
        other.calories == calories;
  }

  @override
  int get hashCode => Object.hash(water, steps, calories);
}

@immutable
class ExtendedHealthStat {
  const ExtendedHealthStat({
    required this.id,
    required this.label,
    required this.value,
    required this.unit,
    required this.type,
    this.date,
  });

  final int id;
  final String label;
  final String value;
  final String unit;
  final String type;
  final String? date;

  ExtendedHealthStat copyWith({
    int? id,
    String? label,
    String? value,
    String? unit,
    String? type,
    String? date,
  }) {
    return ExtendedHealthStat(
      id: id ?? this.id,
      label: label ?? this.label,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      type: type ?? this.type,
      date: date ?? this.date,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ExtendedHealthStat &&
        other.id == id &&
        other.label == label &&
        other.value == value &&
        other.unit == unit &&
        other.type == type &&
        other.date == date;
  }

  @override
  int get hashCode => Object.hash(id, label, value, unit, type, date);

  @override
  String toString() =>
      'ExtendedHealthStat(id: $id, label: $label, value: $value$unit)';
}
