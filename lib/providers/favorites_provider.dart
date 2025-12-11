import 'package:flutter/foundation.dart';
import '/models/search_location_model.dart';
import '/services/storage_service.dart';

class FavoriteProvider with ChangeNotifier {
  final storageService _storage = storageService();
  List<searchLocation> _favorites = [];

  List<searchLocation> get favorites => _favorites;

  Future<void> loadFavorites() async {
    _favorites = await _storage.getFavorites();
    notifyListeners();
  }

  Future<void> addFavorite(searchLocation location) async {
    if (!_favorites.any(
      (fav) => fav.lat == location.lat && fav.lon == location.lon,
    )) {
      _favorites.insert(0, location); // Thêm vào đầu danh sách
      await _storage.saveFavorites(_favorites);
      notifyListeners();
    }
  }

  Future<void> removeFavorite(searchLocation location) async {
    _favorites.removeWhere(
      (fav) => fav.lat == location.lat && fav.lon == location.lon,
    );
    await _storage.saveFavorites(_favorites);
    notifyListeners();
  }

  bool isFavorite(double lat, double lon) {
    return _favorites.any(
      (fav) => (fav.lat - lat).abs() < 0.01 && (fav.lon - lon).abs() < 0.01,
    );
  }
}
