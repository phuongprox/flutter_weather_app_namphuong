import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get openWeatherApiKey =>
      dotenv.env['OPENWEATHER_API_KEY'] ?? ''; //Ẩn api key trong .env
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String oneCallBaseUrl =
      'https://api.openweathermap.org/data/3.0';
}
