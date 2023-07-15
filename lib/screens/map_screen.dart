import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_project/models/driver.dart';
import 'package:flutter_project/screens/components/driver_card.dart';
import 'package:flutter_project/screens/components/location_text_field.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  final _pickupController = TextEditingController();
  final _dropoffController = TextEditingController();
  LatLng? _pickupLocation;
  LatLng? _dropoffLocation;
  LatLng _initialPosition = LatLng(37.7749, -122.4194);
  final List<Driver> drivers = [
    Driver(
      name: 'John Doe',
      carModel: 'Tesla Model S',
      location: LatLng(37.7849, -122.4194),
      imageUrl: 'assets/images/1.jpg',
      rating: 5.0,
    ),
    Driver(
      name: 'Jane Smith',
      carModel: 'Audi A8',
      location: LatLng(37.7749, -122.4294),
        imageUrl: 'assets/images/2.jpg',
      rating: 5.0,
    ),
    Driver(
      name: 'Bob Johnson',
      carModel: 'BMW M5',
      location: LatLng(37.7649, -122.4194),
        imageUrl: 'assets/images/3.jpg',
      rating: 5.0,
    ),
  ];

  bool _showBookRide = false;
  bool _showDriverCards = false;
  bool _showButtons = false;
  Position? position;

  void _toggleBookRide() {
    setState(() {
      _showBookRide = !_showBookRide;
      _showDriverCards = false;
    });
  }

  void _toggleDriverCards() {
    setState(() {
      _showDriverCards = !_showDriverCards;
      _showBookRide = false;
    });
  }

  void _getUserLocation() {
    setState(() async {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _initialPosition = LatLng(position?.latitude?? 37.7780, position?.longitude?? -122.4194);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Ride'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(37.7749, -122.4194),
              zoom: 14.0,
            ),
            markers: {
              if (_pickupLocation != null)
                Marker(
                  markerId: MarkerId('Pickup'),
                  position: _pickupLocation!,
                  infoWindow: InfoWindow(title: 'Pickup Position'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen,
                  ),
                ),
              if (_dropoffLocation != null)
                Marker(
                  markerId: MarkerId('Dropoff'),
                  position: _dropoffLocation!,
                  infoWindow: InfoWindow(title: 'Dropoff Position'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed,
                  ),
                ),
              for (final driver in drivers)
                Marker(
                  markerId: MarkerId(driver.name),
                  position: driver.location,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue,
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center, // Align the content in the center vertically
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage(driver.imageUrl),
                              ),
                              SizedBox(height: 8),
                              Text(
                                driver.name,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                driver.carModel,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 8),
                              RatingBar.builder(
                                initialRating: driver.rating,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 18,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
            },
          ),
          Positioned(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_showBookRide)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Set the background color here
                      borderRadius: BorderRadius.circular(8.0), // Set the border radius here
                    ),
                    child: LocationTextField(
                      controller: _pickupController,
                      labelText: 'Pickup Location',
                      onLocationSelected: (location) {
                        if (location != null) {
                          setState(() {
                            _pickupController.text = location.name;
                            _pickupLocation = location.latLng;
                          });
                          mapController!.animateCamera(
                            CameraUpdate.newLatLng(location.latLng),
                          );
                        }
                      },
                    ),
                  ),

                if (_showBookRide)
                  SizedBox(height: 8.0),
                if (_showBookRide)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Set the background color here
                      borderRadius: BorderRadius.circular(8.0), // Set the border radius here
                    ),
                    child: LocationTextField(
                      controller: _dropoffController,
                      labelText: 'Dropoff Location',
                      onLocationSelected: (location) {
                        if (location != null) {
                          setState(() {
                            _dropoffController.text = location.name;
                            _dropoffLocation = location.latLng;
                          });
                          mapController!.animateCamera(
                            CameraUpdate.newLatLng(location.latLng),
                          );
                        }
                      },
                    ),
                  ),
                if (_showBookRide)
                  SizedBox(height: 16.0),
                if (_showBookRide)
                  ElevatedButton(
                    child: Text('Book Ride'),
                    onPressed: () {
                      // TODO: Implement ride booking logic
                    },
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
              child: MouseRegion(
                onEnter: (event) {
                  setState(() {
                    _showButtons = true;
                  });
                },
                onExit: (event) {
                  setState(() {
                    _showButtons = false;
                  });
                },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedOpacity(
                  opacity: _showButtons ? 0.0 : 1.0,
                  duration: Duration(milliseconds: 300),
                  child: FloatingActionButton(
                    onPressed: _toggleBookRide,
                    child: Icon(Icons.my_location),
                  ),
                ),
                SizedBox(height: 16.0),
                AnimatedOpacity(
                  opacity: _showButtons ? 0.0 : 1.0,
                  duration: Duration(milliseconds: 300),
                  child: FloatingActionButton(
                    onPressed: _toggleDriverCards,
                    child: Icon(Icons.drive_eta_rounded),
                  ),
                ),
              ],
            ),
          )),
          Positioned(
            top: 16.0,
            left: 16.0,
            child: Column(
              children: [
                if (_showDriverCards)
                  for (final driver in drivers)
                    DriverCard(driver: driver),
              ],
            ),
          ),
        ],
      ),
    );
  }
}