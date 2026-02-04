import 'package:flutter/foundation.dart';

@immutable
class Recipe {
  const Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.tag,
    required this.cookTime,
    required this.calories,
  });

  final int id;
  final String name;
  final String description;
  final String image;
  final String tag;
  final String cookTime;
  final String calories;

  Recipe copyWith({
    int? id,
    String? name,
    String? description,
    String? image,
    String? tag,
    String? cookTime,
    String? calories,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      tag: tag ?? this.tag,
      cookTime: cookTime ?? this.cookTime,
      calories: calories ?? this.calories,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Recipe &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
        other.tag == tag &&
        other.cookTime == cookTime &&
        other.calories == calories;
  }

  @override
  int get hashCode => Object.hash(
        id,
        name,
        description,
        image,
        tag,
        cookTime,
        calories,
      );

  @override
  String toString() => 'Recipe(id: $id, name: $name)';
}
