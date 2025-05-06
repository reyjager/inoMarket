// import dart math
import 'dart:math' as math;

class LocationPosition {
  final double latitude;
  final double longitude;

  LocationPosition({required this.latitude, required this.longitude});

  factory LocationPosition.fromJson(Map<String, dynamic> json) {
    return LocationPosition(
      latitude: json['CENTER_LAT'],
      longitude: json['CENTER_LONG'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CENTER_LAT': latitude,
      'CENTER_LONG': longitude,
    };
  }

  @override
  String toString() {
    return 'LocationPosition(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationPosition &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;

  static double calculateDistanceInMeter(
      LocationPosition position1, LocationPosition position2) {
    const double earthRadius = 6371000;
    final double lat1 = position1.latitude;
    final double lat2 = position2.latitude;
    final double lon1 = position1.longitude;
    final double lon2 = position2.longitude;
    final double dLat = _toRadians(lat2 - lat1);
    final double dLon = _toRadians(lon2 - lon1);
    final double a = math.pow(math.sin(dLat / 2), 2) +
        math.cos(_toRadians(lat1)) *
            math.cos(_toRadians(lat2)) *
            math.pow(math.sin(dLon / 2), 2);
    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  static double _toRadians(double degree) {
    return degree * math.pi / 180;
  }
}
