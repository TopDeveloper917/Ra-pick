import 'package:google_maps_flutter/google_maps_flutter.dart';

class Driver {
  final String name;
  final String carModel;
  final LatLng location;
  final String imageUrl;
  final double rating;

  Driver({
    required this.name,
    required this.carModel,
    required this.location,
    required this.imageUrl,
    required this.rating,
  });
}