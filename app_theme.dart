import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences? _prefs;
  late bool _darkTheme;

  bool get darkTheme => _darkTheme;

  AppTheme() {
    _darkTheme = false;
    _loadPrefs();
  }

  switchThemeLight() {
    _darkTheme = false;
    _savePrefs();
    notifyListeners();
  }

  switchThemeDark() {
    _darkTheme = true;
    _savePrefs();
    notifyListeners();
  }

  _initiatePrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  _loadPrefs() async {
    await _initiatePrefs();
    _darkTheme = _prefs?.getBool(key) ?? false;
    notifyListeners();
  }

  _savePrefs() async {
    await _initiatePrefs();
    _prefs?.setBool(key, _darkTheme);
  }
}