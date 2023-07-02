import 'package:google_maps_flutter/google_maps_flutter.dart';


class Location {

  final String name;
  final double latitude;
  final double longitude;

  Location({required this.name, required this.latitude, required this.longitude}) {}

  static Location fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
      name: json['name'],
    );
  }

  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }

  @override
  String toString() => 'Location(name: $name, longitude: $longitude, latitude: $latitude)';

}
