import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/location_provider.dart';
import '/providers/weather_provider.dart';
import '/widgets/current_weather_card.dart';
import '/providers/favorites_provider.dart';
import '/models/search_location_model.dart';
import '/widgets/error_widget.dart';
import '/widgets/loading_shimmer.dart';
import '/utils/constants.dart';
import '/widgets/hourly_forecast_list.dart';
import '/widgets/daily_forecast_list.dart';
import 'search_screen.dart';
import 'map_screen.dart';
import 'settings_screen.dart';
import 'forecast_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().loadCachedWeather().then((_) {
        _loadData();
      });
    });
  }

  Future<void> _loadData() async {
    // khi khởi động , luôn lấy vị trí hiện tại
    final locationProvider = context.read<LocationProvider>();
    await locationProvider.loadLocation();

    if (locationProvider.location != null && mounted) {
      final lat = locationProvider.location!.latitude;
      final lon = locationProvider.location!.longitude;
      // ignore: use_build_context_synchronously
      await context.read<WeatherProvider>().fetchWeather(lat, lon);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LocationProvider, WeatherProvider>(
      builder: (context, location, weather, child) {
        // màu nền background dựa vào thời tiết
        final bgColor = getWeatherColor(weather.currentWeather?.icon);

        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            title: const Text('Flutter Weather'),
            backgroundColor: bgColor,
            elevation: 0,
            actions: [
              if (weather.currentWeather != null)
                Consumer<FavoriteProvider>(
                  builder: (context, favoritesProvider, _) {
                    final isFav = favoritesProvider.isFavorite(
                      weather.currentWeather!.lat,
                      weather.currentWeather!.lon,
                    );
                    return IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.white,
                      ),
                      onPressed: () {
                        final current = weather.currentWeather!;
                        final location = searchLocation(
                          name: current.cityName,
                          lat: current.lat,
                          lon: current.lon,
                          country: current.country,
                        );
                        if (isFav) {
                          favoritesProvider.removeFavorite(location);
                        } else {
                          favoritesProvider.addFavorite(location);
                        }
                      },
                    );
                  },
                ),
              IconButton(
                icon: const Icon(Icons.map),
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const MapScreen()));
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SearchScreen()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () =>
                    context.read<WeatherProvider>().refreshWeather(),
              ),
            ],
          ),
          body: _buildBody(location, weather),
        );
      },
    );
  }

  Widget _buildBody(LocationProvider location, WeatherProvider weather) {
    if (weather.currentWeather == null &&
        (location.loading || weather.loading)) {
      return const LoadingShimmer();
    }

    if (location.error != null) {
      return CustomErrorWidget(message: 'Location Error: ${location.error}');
    }

    if (weather.error != null && weather.currentWeather == null) {
      return CustomErrorWidget(message: 'Weather Error: ${weather.error}');
    }

    if (weather.currentWeather == null) {
      return const Center(child: Text('No weather data. Pull to refresh.'));
    }

    return RefreshIndicator(
      onRefresh: () => context.read<WeatherProvider>().refreshWeather(),
      child: _buildWeatherUI(weather),
    );
  }

  Widget _buildWeatherUI(WeatherProvider weather) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        if (weather.currentWeather != null)
          CurrentWeatherCard(weather: weather.currentWeather!),
        const SizedBox(height: 20),
        if (weather.hourly != null && weather.hourly!.isNotEmpty)
          HourlyForecastList(hourly: weather.hourly!),
        const SizedBox(height: 20),
        if (weather.forecast != null && weather.forecast!.daily.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Next 5 Days',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ForecastScreen()),
                  );
                },
                child: const Text(
                  'See All',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          DailyForecastList(daily: weather.forecast!.daily),
        ],
      ],
    );
  }
}
