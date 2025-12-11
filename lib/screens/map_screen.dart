import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '/config/api_config.dart';
import '/providers/map_provider.dart';
import '/providers/weather_provider.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.read<WeatherProvider>();
    final initialCenter = LatLng(
      weatherProvider.currentWeather?.lat ?? 51.509865,
      weatherProvider.currentWeather?.lon ?? -0.118092,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Weather Map')),
      body: Consumer<mapProvider>(
        builder: (context, mapProvider, child) {
          return FlutterMap(
            options: MapOptions(initialCenter: initialCenter, initialZoom: 6.0),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName:
                    'com.example.flutter_weatherapp_namphuong',
              ),
              TileLayer(
                urlTemplate:
                    'https://tile.openweathermap.org/map/${mapProvider.layerName}/{z}/{x}/{y}.png?appid=${ApiConfig.openWeatherApiKey}',
                backgroundColor: Colors.transparent, // Để nhìn thấy lớp nền
              ),
            ],
          );
        },
      ),
      floatingActionButton: _buildLayerSelector(context),
    );
  }

  Widget _buildLayerSelector(BuildContext context) {
    final mapProviderState = context.read<mapProvider>();
    return DropdownButton<layerWeather>(
      value: context.watch<mapProvider>().currentLayer,
      icon: const Icon(Icons.layers, color: Colors.white),
      dropdownColor: Colors.blueGrey,
      style: const TextStyle(color: Colors.white),
      items: const [
        DropdownMenuItem(
          value: layerWeather.temperature,
          child: Text('Temperature'),
        ),
        DropdownMenuItem(value: layerWeather.wind, child: Text('Wind Speed')),
        DropdownMenuItem(
          value: layerWeather.precipitation,
          child: Text('Precipitation'),
        ),
        DropdownMenuItem(value: layerWeather.clouds, child: Text('Clouds')),
      ],
      onChanged: (layerWeather? newValue) {
        if (newValue != null) {
          mapProviderState.setLayer(newValue);
        }
      },
    );
  }
}
