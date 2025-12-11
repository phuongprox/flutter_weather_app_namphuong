class WeatherModel {
  final String cityName;
  final double temp;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final String description;
  final String icon;
  final double lat;
  final double lon;
  final String country;

  WeatherModel({
    required this.cityName,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.icon,
    required this.lat,
    required this.lon,
    required this.country,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];
    final wind = json['wind'];
    final coord = json['coord'];
    final sys = json['sys'];

    return WeatherModel(
      cityName: json['name'] ?? '',
      temp: (main['temp'] as num).toDouble(),
      feelsLike: (main['feels_like'] as num).toDouble(),
      humidity: main['humidity'] as int,
      windSpeed: (wind['speed'] as num).toDouble(),
      description: weather['description'] ?? '',
      icon: weather['icon'] ?? '01d',
      lat: (coord['lat'] as num).toDouble(),
      lon: (coord['lon'] as num).toDouble(),
      country: sys != null ? sys['country'] ?? '' : '',
    );
  }

  WeatherModel copyWith({
    String? cityName,
    double? temp,
    double? feelsLike,
    int? humidity,
    double? windSpeed,
    String? description,
    String? icon,
    double? lat,
    double? lon,
    String? country,
  }) {
    return WeatherModel(
      cityName: cityName ?? this.cityName,
      temp: temp ?? this.temp,
      feelsLike: feelsLike ?? this.feelsLike,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      country: country ?? this.country,
    );
  }
}
