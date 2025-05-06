import 'package:inomarket/auth/service/global_auth_service.dart';

class Address {
  final int? id;
  final String? label;
  final double lat;
  final double lng;
  final String? address;

  Address({
    required this.label,
    required this.lat,
    required this.lng,
    required this.address,
    this.id,
  });

  @override
  String toString() {
    return "{label: $label,lat: $lat,lng: $lng,address: $address}";
  }

  Map<String, dynamic> toMap() {
    return {
      "accountId": GlobalAuthService.loggedInUser().id.toString(),
      "latitude": lat.toString(),
      "longitude": lng.toString(),
      "label": label,
      "address": address ?? "",
    };
  }

  static Address fromMap(Map<String, dynamic> data) => Address(
        id: data["ID"],
        label: data["LABEL"],
        lat: double.parse(data["LATITUDE"]),
        lng: double.parse(data["LONGITUDE"]),
        address: data["ADDRESS"],
      );
}
