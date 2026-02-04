import 'package:flutter/foundation.dart';

enum ClassCategory { popular, beginner, therapy }

@immutable
class PopularClass {
  const PopularClass({
    required this.id,
    required this.name,
    required this.instructor,
    required this.time,
    required this.image,
    required this.category,
    required this.categoryLabel,
  });

  final int id;
  final String name;
  final String instructor;
  final String time;
  final String image;
  final ClassCategory category;
  final String categoryLabel;

  PopularClass copyWith({
    int? id,
    String? name,
    String? instructor,
    String? time,
    String? image,
    ClassCategory? category,
    String? categoryLabel,
  }) {
    return PopularClass(
      id: id ?? this.id,
      name: name ?? this.name,
      instructor: instructor ?? this.instructor,
      time: time ?? this.time,
      image: image ?? this.image,
      category: category ?? this.category,
      categoryLabel: categoryLabel ?? this.categoryLabel,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PopularClass &&
        other.id == id &&
        other.name == name &&
        other.instructor == instructor &&
        other.time == time &&
        other.image == image &&
        other.category == category &&
        other.categoryLabel == categoryLabel;
  }

  @override
  int get hashCode => Object.hash(
        id,
        name,
        instructor,
        time,
        image,
        category,
        categoryLabel,
      );

  @override
  String toString() => 'PopularClass(id: $id, name: $name)';
}
