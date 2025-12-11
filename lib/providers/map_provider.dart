import 'package:flutter/foundation.dart';

enum layerWeather { temperature, wind, precipitation, clouds }

class mapProvider with ChangeNotifier {
  layerWeather _currentLayer = layerWeather.temperature;

  layerWeather get currentLayer => _currentLayer;

  // từng kiểu bản đồ tương ứng với api của openweathermap (nhiệt độ , gió , mây , mưa )
  String get layerName {
    switch (_currentLayer) {
      case layerWeather.temperature:
        return 'temp_new';
      case layerWeather.wind:
        return 'wind_new';
      case layerWeather.precipitation:
        return 'precipitation_new';
      case layerWeather.clouds:
        return 'clouds_new';
    }
  }

  /// cập nhật lớp bản đồ hiện tại và thông báo cho các listener.
  void setLayer(layerWeather layer) {
    _currentLayer = layer;
    notifyListeners();
  }
}
