import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings with ChangeNotifier {
  AppSettings() {
    loadPreferences();
  }

  bool _isDark = true;

  set isDark(bool value) {
    _isDark = value;
    savePreferences();
    notifyListeners();
  }

  get isDark => _isDark;

  void savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
  }

  void loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDark = (prefs.getBool('isDark') ?? true);
    notifyListeners();
  }
}
