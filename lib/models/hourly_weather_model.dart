class hourWeather {
  final DateTime time;
  final double temp;
  final String icon;

  hourWeather({required this.time, required this.temp, required this.icon});

  factory hourWeather.fromJson(Map<String, dynamic> json) {
    return hourWeather(
      time: DateTime.fromMillisecondsSinceEpoch((json['dt'] as int) * 1000),
      temp: (json['temp'] as num).toDouble(),
      icon: json['weather'][0]['icon'] ?? '01d',
    );
  }
}
