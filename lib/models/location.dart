import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationModel {
  final String name;
  final LatLng latLng;

  LocationModel({required this.name, required this.latLng});
}