import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/hourly_weather_model.dart';
import '../providers/settings_provider.dart';
import '../utils/date_formatter.dart';
import '../utils/unit_converter.dart';

class HourlyForecastList extends StatelessWidget {
  final List<hourWeather> hourly;

  const HourlyForecastList({super.key, required this.hourly});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<settingProvider>();

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hourly.length > 24
            ? 24
            : hourly.length, // Giới hạn hiển thị 24 giờ
        itemBuilder: (context, index) {
          final item = hourly[index];
          return Card(
            color: Colors.white.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormatter.formatHour(item.time),
                    style: const TextStyle(color: Colors.white),
                  ),
                  Image.network(
                    'https://openweathermap.org/img/wn/${item.icon}.png',
                    width: 50,
                    height: 50,
                  ),
                  Text(
                    UnitConverter.formatTemperature(
                      item.temp,
                      settings.isCelsius,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
