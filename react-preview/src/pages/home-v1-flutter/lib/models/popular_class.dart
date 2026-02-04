enum ClassCategory { popular, beginner, therapy }

class PopularClass {
  final int id;
  final String name;
  final String instructor;
  final String time;
  final String image;
  final ClassCategory category;
  final String categoryLabel;

  PopularClass({
    required this.id,
    required this.name,
    required this.instructor,
    required this.time,
    required this.image,
    required this.category,
    required this.categoryLabel,
  });
}
