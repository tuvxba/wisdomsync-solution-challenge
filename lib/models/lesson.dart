import 'package:flutter/material.dart';

class Lesson {
  final String title;
  final String category;
  final String description;
  final double rating;
  final int tokensRequired;
  final IconData categoryIcon;

  Lesson({
    required this.title,
    required this.category,
    required this.description,
    required this.rating,
    this.tokensRequired = 20,
    this.categoryIcon = Icons.category,
  });
}
