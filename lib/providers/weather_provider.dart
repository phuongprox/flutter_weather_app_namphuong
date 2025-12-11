import 'dart:async';
import 'package:flutter/foundation.dart';
import '/models/weather_model.dart';
import '/models/location_model.dart';
import '/models/forecast_model.dart';
import '/models/hourly_weather_model.dart';
import '/services/weather_service.dart';
import '/services/storage_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _service = WeatherService();
  final storageService _storage = storageService();

  WeatherModel? _currentWeather;
  forecastModel? _forecast;
  List<hourWeather>? _hourly;
  bool _loading = false;
  locationModel? _lastFetchedLocation;
  String? _error;

  WeatherModel? get currentWeather => _currentWeather;
  forecastModel? get forecast => _forecast;
  List<hourWeather>? get hourly => _hourly;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> fetchWeather(double lat, double lon, {String? cityName}) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final weatherJson = await _service
          .fetchCurrentWeatherByCoordsAsJson(lat, lon)
          .timeout(const Duration(seconds: 10));
      await _storage.cacheWeather(weatherJson);

      // cập nhật thời tiết hiện tại
      _currentWeather = await _service
          .fetchCurrentWeatherByCoords(lat, lon)
          .timeout(const Duration(seconds: 10));
      if (cityName != null && _currentWeather != null) {
        _currentWeather = _currentWeather!.copyWith(cityName: cityName);
      }
      try {
        _forecast = await _service
            .fetchForecast(lat, lon)
            .timeout(const Duration(seconds: 10));
      } catch (e) {
        debugPrint('Failed to load forecast: $e');
        _forecast = _createMockForecast();
      }
      try {
        _hourly = await _service
            .fetchHourly(lat, lon)
            .timeout(const Duration(seconds: 10));
      } catch (e) {
        debugPrint('Failed to load hourly weather: $e');
        _hourly = _createMockHourly();
      }

      _lastFetchedLocation = locationModel(latitude: lat, longitude: lon);
    } on TimeoutException catch (_) {
      _error = "Connection timed out. Please check your internet.";
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchWeatherByCity(String city) async {
    try {
      // lấy thông tin thời tiết hiện tại
      final current = await _service.fetchCurrentWeatherByCity(city);
      final lat = current.lat;
      final lon = current.lon;
      await fetchWeather(lat, lon, cityName: current.cityName);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refreshWeather() async {
    if (_lastFetchedLocation != null) {
      await fetchWeather(
        _lastFetchedLocation!.latitude,
        _lastFetchedLocation!.longitude,
        cityName: _currentWeather?.cityName,
      );
    }
  }

  Future<void> loadCachedWeather() async {
    final cachedData = await _storage.getCachedWeather();
    if (cachedData != null) {
      _currentWeather = WeatherModel.fromJson(cachedData);
      notifyListeners();
      _lastFetchedLocation = locationModel(
        latitude: _currentWeather!.lat,
        longitude: _currentWeather!.lon,
      );
    }
  }

  // mock design
  forecastModel _createMockForecast() {
    final now = DateTime.now();
    return forecastModel(
      daily: List.generate(
        5,
        (index) => DailyForecast(
          date: now.add(Duration(days: index)),
          minTemp: 18.0 + index,
          maxTemp: 25.0 + index,
          description: 'mock weather',
          icon: '01d',
        ),
      ),
    );
  }

  List<hourWeather> _createMockHourly() {
    final now = DateTime.now();
    return List.generate(
      24,
      (index) => hourWeather(
        time: now.add(Duration(hours: index)),
        temp: 22.0 + (index % 4),
        icon: '02d',
      ),
    );
  }
}
