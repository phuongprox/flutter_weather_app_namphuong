import 'package:flutter/material.dart';

// Màu sắc chủ đạo cho các điều kiện thời tiết khác nhau
const Color kColorClear = Color(0xFF4A90E2);
const Color kColorClouds = Color(0xFF54717A);
const Color kColorRain = Color(0xFF5D646E);
const Color kColorThunderstorm = Color(0xFF2C3E50);
const Color kColorSnow = Color(0xFF7D97A9);
const Color kColorAtmosphere = Color(0xFF6E8898);

/// Trả về một màu nền dựa trên mã điều kiện thời tiết từ API OpenWeatherMap.
/// Tham khảo: https://openweathermap.org/weather-conditions
Color getWeatherColor(String? icon) {
  if (icon == null) return kColorClear;

  switch (icon.substring(0, 2)) {
    case '01': // clear sky
      return kColorClear;
    case '02': // few clouds
    case '03': // scattered clouds
    case '04': // broken clouds
      return kColorClouds;
    case '09': // shower rain
    case '10': // rain
      return kColorRain;
    case '11': // thunderstorm
      return kColorThunderstorm;
    case '13': // snow
      return kColorSnow;
    case '50': // mist, smoke, haze, etc.
      return kColorAtmosphere;
    default:
      return kColorClear;
  }
}
