import 'package:flutter/material.dart';

/// Domain model for a training course.
class Course {
  const Course({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.duration,
    required this.lessons,
    required this.price,
    required this.icon,
    required this.color,
    this.progress = 0,
    this.imageUrl,
  });

  final String id;
  final String title;
  final String category;
  final String description;
  final String duration;
  final int lessons;
  final int price;
  final IconData icon;
  final Color color;
  final double progress;
  final String? imageUrl;

  Course copyWith({double? progress}) => Course(
        id: id,
        title: title,
        category: category,
        description: description,
        duration: duration,
        lessons: lessons,
        price: price,
        icon: icon,
        color: color,
        progress: progress ?? this.progress,
        imageUrl: imageUrl,
      );
}
