import 'package:flutter/material.dart';

class CategoryModel {
  String? title;
  Color? color;
  CategoryModel({
    required this.title,
    required this.color,
  });
  static final aa = [
    CategoryModel(title: "Focus", color: Colors.grey),
    CategoryModel(title: "Study", color: Colors.blue),
    CategoryModel(title: "Work", color: Colors.green),
    CategoryModel(title: "Read", color: Colors.yellow),
    CategoryModel(title: "Fitness", color: Colors.purple),
  ];
}
