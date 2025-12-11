import 'package:geolocator/geolocator.dart';
import '/models/location_model.dart';

class LocationService {
  Future<locationModel> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    // hỏi quyền truy cập vị trí trên máy ảo hoặc thiết bị thật
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // timeout lấy vị trí hiện tại và timelimit tránh treo ứng dụng
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        timeLimit: const Duration(seconds: 5),
      );
      return locationModel(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      final lastKnown = await Geolocator.getLastKnownPosition();
      if (lastKnown != null) {
        return locationModel(
          latitude: lastKnown.latitude,
          longitude: lastKnown.longitude,
        );
      }
      rethrow;
    }
  }
}
