import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/favorites_provider.dart';
import '/providers/weather_provider.dart';
import '/models/search_location_model.dart';
import '/services/weather_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _textController = TextEditingController();
  final WeatherService _weatherService = WeatherService();
  List<searchLocation> _suggestions = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    context.read<FavoriteProvider>().loadFavorites();
    _textController.addListener(() {
      if (_textController.text.length > 2) {
        _fetchSuggestions(_textController.text);
      } else {
        setState(() {
          _suggestions = [];
        });
      }
    });
  }

  Future<void> _fetchSuggestions(String query) async {
    setState(() => _isSearching = true);
    try {
      final results = await _weatherService.searchLocations(query);
      setState(() => _suggestions = results);
    } catch (e) {
    } finally {
      setState(() => _isSearching = false);
    }
  }

  Future<void> _onLocationSelected(searchLocation location) async {
    final weatherProvider = context.read<WeatherProvider>();

    try {
      await weatherProvider.fetchWeather(
        location.lat,
        location.lon,
        cityName: location.name,
      );
      if (mounted) Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to fetch weather for ${location.name}'),
          ),
        );
      }
    }
  }

  Future<void> _onSearchSubmitted(String query) async {
    if (query.isEmpty) return;
    if (_suggestions.isNotEmpty) {
      await _onLocationSelected(_suggestions.first);
      return;
    }

    setState(() => _isSearching = true);
    try {
      final results = await _weatherService.searchLocations(query);
      if (results.isNotEmpty && mounted) {
        await _onLocationSelected(results.first);
      }
    } finally {
      if (mounted) setState(() => _isSearching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search City')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _textController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                suffix: _isSearching
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : null,
              ),
              onSubmitted: _onSearchSubmitted,
            ),
          ),
          Expanded(
            child: _suggestions.isNotEmpty
                ? _buildSuggestions()
                : _buildFavoritesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      itemCount: _suggestions.length,
      itemBuilder: (context, index) {
        final location = _suggestions[index];
        return ListTile(
          title: Text(location.displayName),
          onTap: () => _onLocationSelected(location),
        );
      },
    );
  }

  Widget _buildFavoritesList() {
    return Consumer<FavoriteProvider>(
      builder: (context, provider, child) {
        if (provider.favorites.isEmpty) {
          return const Center(
            child: Text('Search for a city to add it to your favorites.'),
          );
        }
        return ListView.builder(
          itemCount: provider.favorites.length,
          itemBuilder: (context, index) {
            final location = provider.favorites[index];
            return Dismissible(
              key: Key(location.displayName),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                provider.removeFavorite(location);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${location.name} removed')),
                );
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: ListTile(
                title: Text(location.displayName),
                onTap: () => _onLocationSelected(location),
              ),
            );
          },
        );
      },
    );
  }
}
