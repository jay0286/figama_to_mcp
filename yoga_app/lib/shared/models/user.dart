import 'package:flutter/foundation.dart';

@immutable
class User {
  const User({
    required this.id,
    required this.name,
    required this.profileImage,
  });

  final int id;
  final String name;
  final String profileImage;

  User copyWith({
    int? id,
    String? name,
    String? profileImage,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.name == name &&
        other.profileImage == profileImage;
  }

  @override
  int get hashCode => Object.hash(id, name, profileImage);

  @override
  String toString() => 'User(id: $id, name: $name)';
}
