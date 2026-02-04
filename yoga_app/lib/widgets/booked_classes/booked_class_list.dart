import 'package:flutter/material.dart';
import '../../models/booked_class.dart';
import 'booked_class_card.dart';

class BookedClassList extends StatelessWidget {
  final List<BookedClass> classes;
  final Function(BookedClass)? onClassTap;

  const BookedClassList({
    super.key,
    required this.classes,
    this.onClassTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 132,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: classes.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return BookedClassCard(
            classData: classes[index],
            onTap: () => onClassTap?.call(classes[index]),
          );
        },
      ),
    );
  }
}
