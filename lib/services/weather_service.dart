import 'dart:convert';
import 'package:http/http.dart' as http;
import '/config/api_config.dart';
import '/models/weather_model.dart';
import '/models/forecast_model.dart';
import '/models/hourly_weather_model.dart';
import '/models/search_location_model.dart';

class WeatherService {
  final String apiKey = ApiConfig.openWeatherApiKey;

  Future<WeatherModel> fetchCurrentWeatherByCity(String city) async {
    final url = Uri.parse(
      "${ApiConfig.baseUrl}/weather?q=$city&units=metric&appid=$apiKey",
    );
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return WeatherModel.fromJson(json);
    } else {
      throw Exception('Failed to load current weather');
    }
  }

  Future<WeatherModel> fetchCurrentWeatherByCoords(
    double lat,
    double lon,
  ) async {
    final url = Uri.parse(
      "${ApiConfig.baseUrl}/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey",
    );
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return WeatherModel.fromJson(json);
    } else {
      throw Exception('Failed to load current weather by coords');
    }
  }

  Future<Map<String, dynamic>> fetchCurrentWeatherByCoordsAsJson(
    double lat,
    double lon,
  ) async {
    final url = Uri.parse(
      "${ApiConfig.baseUrl}/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey",
    );
    final res = await http.get(url);
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load current weather JSON by coords');
    }
  }

  Future<forecastModel> fetchForecast(double lat, double lon) async {
    // sử dung onecall API để lấy forecast
    final url = Uri.parse(
      "${ApiConfig.oneCallBaseUrl}/onecall?lat=$lat&lon=$lon&exclude=minutely,alerts&units=metric&appid=$apiKey",
    );
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return forecastModel.fromJson(json);
    } else {
      throw Exception('Failed to load forecast');
    }
  }

  Future<List<hourWeather>> fetchHourly(double lat, double lon) async {
    final url = Uri.parse(
      "${ApiConfig.oneCallBaseUrl}/onecall?lat=$lat&lon=$lon&exclude=minutely,daily,alerts&units=metric&appid=$apiKey",
    );
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      final list = (json['hourly'] as List)
          .map((e) => hourWeather.fromJson(e))
          .toList();
      return list;
    } else {
      throw Exception('Failed to load hourly');
    }
  }

  Future<List<searchLocation>> searchLocations(String query) async {
    final url = Uri.parse(
      'http://api.openweathermap.org/geo/1.0/direct?q=$query&limit=5&appid=$apiKey',
    );
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final locations = (jsonDecode(res.body) as List)
          .map((data) => searchLocation.fromJson(data))
          .toList();
      return locations;
    } else {
      throw Exception('Failed to search locations');
    }
  }
}
