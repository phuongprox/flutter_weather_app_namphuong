import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '/models/search_location_model.dart';

class storageService {
  static const _keyCachedWeather = 'cached_weather';
  static const _keyFavorites = 'fav_cities';
  static const _keyIsCelsius = 'is_celsius';
  static const _keyThemeMode = 'theme_mode';

  Future<void> cacheWeather(Map<String, dynamic> json) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyCachedWeather, jsonEncode(json));
  }

  Future<Map<String, dynamic>?> getCachedWeather() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_keyCachedWeather);
    if (s == null) return null;
    return jsonDecode(s) as Map<String, dynamic>;
  }

  Future<List<searchLocation>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favStrings = prefs.getStringList(_keyFavorites) ?? [];
    return favStrings.map((s) => searchLocation.fromJsonString(s)).toList();
  }

  Future<void> saveFavorites(List<searchLocation> list) async {
    final prefs = await SharedPreferences.getInstance();
    final favStrings = list.map((loc) => loc.toJson()).toList();
    await prefs.setStringList(_keyFavorites, favStrings);
  }

  Future<void> saveTemperature(bool isCelsius) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsCelsius, isCelsius);
  }

  Future<bool> getTemperature() async {
    final prefs = await SharedPreferences.getInstance();
    // celsius mặc định
    return prefs.getBool(_keyIsCelsius) ?? true;
  }

  Future<void> saveThemeMode(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyThemeMode, themeMode);
  }

  Future<String> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    // theme mặc định
    return prefs.getString(_keyThemeMode) ?? 'system';
  }
}
