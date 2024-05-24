import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerProvider extends ChangeNotifier {
  int _timeCount = 10;
  int get timeCount => _timeCount;
  TimerProvider() {
    _loadTimerFromPreferences();
  }
  void timeCountAdd(int count) {
    _timeCount = count;
    _saveTimerToPreferences();
    notifyListeners();
  }

  Future<void> _saveTimerToPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt("localTimer", _timeCount!);
    } catch (e) {
      print("Error saving timer: $e");
    }
  }

  Future<void> _loadTimerFromPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _timeCount = prefs.getInt("localTimer") ?? 5;
      notifyListeners();
    } catch (e) {
      print("Error loading timer: $e");
    }
  }
}
