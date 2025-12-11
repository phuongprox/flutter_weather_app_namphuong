import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/forecast_model.dart';
import '../providers/settings_provider.dart';
import '../utils/date_formatter.dart';
import '../utils/unit_converter.dart';

class DailyForecastList extends StatelessWidget {
  final List<DailyForecast> daily;

  const DailyForecastList({super.key, required this.daily});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<settingProvider>();

    return Card(
      color: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: daily.length > 5
            ? 5
            : daily.length, // Giới hạn hiển thị 5 ngày
        itemBuilder: (context, index) {
          final item = daily[index];
          return ListTile(
            leading: Image.network(
              'https://openweathermap.org/img/wn/${item.icon}.png',
            ),
            title: Text(
              DateFormatter.formatDay(item.date),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              '${UnitConverter.formatTemperature(item.maxTemp, settings.isCelsius)} / ${UnitConverter.formatTemperature(item.minTemp, settings.isCelsius)}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
