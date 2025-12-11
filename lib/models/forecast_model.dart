class DailyForecast {
  final DateTime date;
  final double minTemp;
  final double maxTemp;
  final String description;
  final String icon;

  DailyForecast({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
    required this.icon,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      date: DateTime.fromMillisecondsSinceEpoch((json['dt'] as int) * 1000),
      minTemp: (json['temp']['min'] as num).toDouble(),
      maxTemp: (json['temp']['max'] as num).toDouble(),
      description: json['weather'][0]['description'] ?? '',
      icon: json['weather'][0]['icon'] ?? '01d',
    );
  }
}

class forecastModel {
  final List<DailyForecast> daily;
  forecastModel({required this.daily});

  factory forecastModel.fromJson(Map<String, dynamic> json) {
    final list = (json['daily'] as List)
        .map((e) => DailyForecast.fromJson(e))
        .toList();
    return forecastModel(daily: list);
  }
}
