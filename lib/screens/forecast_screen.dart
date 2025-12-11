import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../providers/settings_provider.dart';
import '../utils/date_formatter.dart';
import '../utils/unit_converter.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();
    final settings = context.watch<settingProvider>();
    final forecast = weatherProvider.forecast;

    return Scaffold(
      appBar: AppBar(title: const Text('7-Day Forecast')),
      body: forecast == null || forecast.daily.isEmpty
          ? const Center(child: Text('No forecast data available'))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: forecast.daily.length,
              itemBuilder: (context, index) {
                final item = forecast.daily[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormatter.formatDay(item.date),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.description,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.network(
                            'https://openweathermap.org/img/wn/${item.icon}@2x.png',
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.cloud,
                                size: 40,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                UnitConverter.formatTemperature(
                                  item.maxTemp,
                                  settings.isCelsius,
                                ),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                UnitConverter.formatTemperature(
                                  item.minTemp,
                                  settings.isCelsius,
                                ),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
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
