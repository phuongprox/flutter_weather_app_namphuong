import 'dart:convert';

class searchLocation {
  final String name;
  final double lat;
  final double lon;
  final String country;
  final String? state;

  searchLocation({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    this.state,
  });

  String get displayName {
    if (state != null && state!.isNotEmpty) {
      return '$name, $state, $country';
    }
    return '$name, $country';
  }

  factory searchLocation.fromJson(Map<String, dynamic> json) {
    return searchLocation(
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      country: json['country'] as String,
      state: json['state'] as String?,
    );
  }

  // Tiện ích để serialization khi lưu vào favorites
  String toJson() => jsonEncode({
    'name': name,
    'lat': lat,
    'lon': lon,
    'country': country,
    'state': state,
  });
  factory searchLocation.fromJsonString(String source) =>
      searchLocation.fromJson(jsonDecode(source));
}
