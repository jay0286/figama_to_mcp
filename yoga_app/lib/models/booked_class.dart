import 'package:flutter/material.dart';

class BookedClass {
  final int id;
  final String instructor;
  final String instructorImage;
  final String className;
  final String time;
  final double rating;
  final Color bgColor;

  BookedClass({
    required this.id,
    required this.instructor,
    required this.instructorImage,
    required this.className,
    required this.time,
    required this.rating,
    required this.bgColor,
  });
}
