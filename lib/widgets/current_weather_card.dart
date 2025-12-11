import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/weather_model.dart';
import '../providers/settings_provider.dart';
import '../utils/unit_converter.dart';

class CurrentWeatherCard extends StatelessWidget {
  final WeatherModel weather;
  const CurrentWeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    // Lắng nghe thay đổi từ SettingsProvider
    final settings = context.watch<settingProvider>();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              weather.cityName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Image.network(
                  'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                ),
                const SizedBox(width: 16),
                Text(
                  // Sử dụng UnitConverter để định dạng nhiệt độ
                  UnitConverter.formatTemperature(
                    weather.temp,
                    settings.isCelsius,
                  ),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
            // Sử dụng UnitConverter cho nhiệt độ 'cảm giác như'
            Text(
              'Feels like: ${UnitConverter.formatTemperature(weather.feelsLike, settings.isCelsius)}',
            ),
            Text('Humidity: ${weather.humidity}%'),
            Text('Wind: ${weather.windSpeed} m/s'),
            Text(weather.description),
          ],
        ),
      ),
    );
  }
}
