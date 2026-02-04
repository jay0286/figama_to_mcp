import 'package:flutter/material.dart';
import '../../../../shared/models/booked_class.dart';
import 'booked_class_card.dart';

class BookedClassList extends StatelessWidget {
  const BookedClassList({
    super.key,
    required this.classes,
    this.onClassTap,
  });

  final List<BookedClass> classes;
  final ValueChanged<BookedClass>? onClassTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 132,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: classes.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final classData = classes[index];
          return BookedClassCard(
            classData: classData,
            onTap: () => onClassTap?.call(classData),
          );
        },
      ),
    );
  }
}
