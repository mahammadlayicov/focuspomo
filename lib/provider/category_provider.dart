
import 'package:flutter/material.dart';
import 'package:pomodoro_app/models/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryProvider extends ChangeNotifier {
  String? _title = "";
  String? get title => _title;

  CategoryProvider() {
    _loadCategoryFromPreferences();
  }

  void selectCategory(CategoryModel categoryModel) {
    _title = categoryModel.title;
    _saveCategoryToPreferences();
    notifyListeners();
  }

  Future<void> _saveCategoryToPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("localCategory", _title!);
    } catch (e) {
      print("Error saving category: $e");
    }
  }

  Future<void> _loadCategoryFromPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _title = prefs.getString("localCategory") ?? "";
      notifyListeners();
    } catch (e) {
      print("Error loading category: $e");
    }
  }
}
