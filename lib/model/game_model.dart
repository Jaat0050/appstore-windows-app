import 'package:flutter/material.dart';

class Game {
  final String name;
  final String category;
  final String imageUrl;
  final Key? key;

  Game({
    required this.name,
    required this.category,
    required this.imageUrl,
    this.key,
  });
}