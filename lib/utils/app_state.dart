import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../requests/google_maps_requests.dart';

class AppState with ChangeNotifier {
  static LatLng? _initialPosition = null;
  LatLng? _lastPosition = _initialPosition;
  bool locationServiceActive = true;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  GoogleMapController? _mapController;
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  LatLng? get initialPosition => _initialPosition;
  LatLng? get lastPosition => _lastPosition;
  GoogleMapsServices get googleMapsServices => _googleMapsServices;
  GoogleMapController? get mapController => _mapController;
  Set<Marker> get markers => _markers;
  Set<Polyline> get polyLines => _polyLines;

  AppState() {
    _getUserLocation();
    _loadingInitialPosition();
  }

  // TO GET THE USERS LOCATION
  void _getUserLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    print("GET USER METHOD RUNNING =========");
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    // _initialPosition = LatLng(position.latitude, position.longitude);
    _initialPosition = LatLng(37.7749, -122.4194);
    print(
        "the latitude is: ${position.longitude} and the longitude is: ${position.longitude}");
    print("initial position is : ${_initialPosition.toString()}");
    locationController.text = placemarks[0].name ?? '';
    notifyListeners();
  }

  // TO CREATE ROUTE
  void createRoute(String encodedPolyline) {
    _polyLines.add(Polyline(
      polylineId: PolylineId(_lastPosition.toString()),
      width: 10,
      points: _convertToLatLng(_decodePolyline(encodedPolyline)),
      color: Colors.black,
    ));
    notifyListeners();
  }

  // ADD A MARKER ON THE MAP
  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
      markerId: MarkerId(_lastPosition.toString()),
      position: location,
      infoWindow: InfoWindow(title: address, snippet: 'Go here'),
      icon: BitmapDescriptor.defaultMarker,
    ));
    notifyListeners();
  }

  // CONVERT DECODED POLYLINE TO LATLNG LIST
  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i += 2) {
      result.add(LatLng(points[i], points[i + 1]));
    }
    return result;
  }

  // DECODE POLYLINE
  List<int> _decodePolyline(String polyline) {
    final List<int> encoded = polyline.codeUnits;
    final List<int> result = <int>[];
    int index = 0;
    int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int resultValue = 0;
      do {
        b = encoded[index] - 63;
        resultValue |= (b & 0x1f) << (shift * 5);
        shift += 5;
        index++;
      } while (b >= 32);

      lat += ((resultValue & 1) == 1 ? ~(resultValue >> 1) : (resultValue >> 1));
      shift = 0;
      resultValue = 0;

      do {
        b = encoded[index] - 63;
        resultValue |= (b & 0x1f) << (shift * 5);
        shift += 5;
        index++;
      } while (b >= 32);

      lng += ((resultValue & 1) == 1 ? ~(resultValue >> 1) : (resultValue >> 1));
      result.add(lat);
      result.add(lng);
    }
    return result;
  }

  // SEND REQUEST
  void sendRequest(String intendedLocation) async {
    List<Location> locations = await locationFromAddress(intendedLocation);
    if (locations != null && locations.isNotEmpty) {
      Location location = locations[0];
      double latitude = location.latitude;
      double longitude = location.longitude;
      LatLng destination = LatLng(latitude, longitude);

      _addMarker(destination, intendedLocation);
      String route = await _googleMapsServices.getRouteCoordinates(
          _initialPosition!, destination);
      createRoute(route);
      notifyListeners();
    } else {
      print('No location found for the given address');
    }
  }

  // ON CAMERA MOVE
  void onCameraMove(CameraPosition position) {
    _lastPosition = position.target;
    notifyListeners();
  }

  // ON MAP CREATED
  void onCreated(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  // LOADING INITIAL POSITION
  void _loadingInitialPosition() async {
    await Future.delayed(Duration(seconds: 5)).then((_) {
      if (_initialPosition == null) {
        locationServiceActive = false;
        notifyListeners();
      }
    });
  }
}
