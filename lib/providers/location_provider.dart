import 'package:flutter/foundation.dart';
import '/services/location_service.dart';
import '/models/location_model.dart';

class LocationProvider extends ChangeNotifier {
  final LocationService _service = LocationService();
  locationModel? location;
  bool loading = false;
  String? error;

  Future<void> loadLocation() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      location = await _service.getCurrentLocation(); //vị trí hiện tại
    } catch (e) {
      debugPrint('Location error: $e. Using default location.');
      location = locationModel(latitude: 21.0285, longitude: 105.8542);
    }
    loading = false;
    notifyListeners();
  }
}
