import 'package:flutter/material.dart';
import '/services/storage_service.dart';

// chỉnh sửa hiển thị nhiệt độ và giao diện light/dark mode
class settingProvider with ChangeNotifier {
  final storageService _storage = storageService();

  bool _isCelsius = true;
  ThemeMode _themeMode = ThemeMode.system;

  bool get isCelsius => _isCelsius;
  ThemeMode get themeMode => _themeMode;

  settingProvider() {
    _loadSetting();
  }

  Future<void> _loadSetting() async {
    _isCelsius = await _storage.getTemperature();
    final themeString = await _storage.getThemeMode();
    _themeMode = _getThemeModeFromString(themeString);
    notifyListeners();
  }

  Future<void> toggleUnit() async {
    _isCelsius = !_isCelsius;
    await _storage.saveTemperature(_isCelsius);
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _storage.saveThemeMode(mode.name);
    notifyListeners();
  }

  ThemeMode _getThemeModeFromString(String themeString) {
    return ThemeMode.values.firstWhere(
      (e) => e.name == themeString,
      orElse: () => ThemeMode.system,
    );
  }
}
