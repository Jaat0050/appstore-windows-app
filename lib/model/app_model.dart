import 'package:flutter/material.dart';

class App {
  final String name;
  final String category;
  final String imageUrl;
  final Key? key;

  App({
    required this.name,
    required this.category,
    required this.imageUrl,
    this.key,
  });
}