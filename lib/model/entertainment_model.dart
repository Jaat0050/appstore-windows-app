import 'package:flutter/material.dart';

class Entertainment {
  final String name;
  final String category;

  final String imageUrl;
  final Key? key;

  Entertainment({
    required this.name,
    required this.category,
    required this.imageUrl,
    this.key,
  });
}
