import 'package:flutter/material.dart';

@immutable
class BookedClass {
  const BookedClass({
    required this.id,
    required this.instructor,
    required this.instructorImage,
    required this.className,
    required this.time,
    required this.rating,
    required this.bgColor,
  });

  final int id;
  final String instructor;
  final String instructorImage;
  final String className;
  final String time;
  final double rating;
  final Color bgColor;

  BookedClass copyWith({
    int? id,
    String? instructor,
    String? instructorImage,
    String? className,
    String? time,
    double? rating,
    Color? bgColor,
  }) {
    return BookedClass(
      id: id ?? this.id,
      instructor: instructor ?? this.instructor,
      instructorImage: instructorImage ?? this.instructorImage,
      className: className ?? this.className,
      time: time ?? this.time,
      rating: rating ?? this.rating,
      bgColor: bgColor ?? this.bgColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BookedClass &&
        other.id == id &&
        other.instructor == instructor &&
        other.instructorImage == instructorImage &&
        other.className == className &&
        other.time == time &&
        other.rating == rating &&
        other.bgColor == bgColor;
  }

  @override
  int get hashCode => Object.hash(
        id,
        instructor,
        instructorImage,
        className,
        time,
        rating,
        bgColor,
      );

  @override
  String toString() => 'BookedClass(id: $id, className: $className)';
}
