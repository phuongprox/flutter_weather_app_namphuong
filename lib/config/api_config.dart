import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  // NOTE: Đừng commit key thật vào repo.
  // Đặt biến trong .env (local) hoặc secure storage.
  static String get openWeatherApiKey =>
      dotenv.env['OPENWEATHER_API_KEY'] ?? '';
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5'; // For current weather
  static const String oneCallBaseUrl =
      'https://api.openweathermap.org/data/3.0'; // For forecast
}
