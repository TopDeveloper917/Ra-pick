import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_project/models/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationSearchDelegate extends SearchDelegate<LocationModel?> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<LocationModel>>(
      future: searchLocations(query!),
      builder: (context, AsyncSnapshot<List<LocationModel>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No results found'));
        }
        final locations = snapshot.data!;
        return ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            final location = locations[index];
            return ListTile(
              title: Text(location.name),
              subtitle: Text('Lat: ${location.latLng.latitude}, Lng: ${location.latLng.longitude}'),
              onTap: () {
                close(context, location);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(); // OSM API does not provide autocomplete functionality
  }

  Future<List<LocationModel>> searchLocations(String query) async {
    final url = 'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=10';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      final locations = data.map((place) {
        return LocationModel(
          name: place['display_name'] ?? '',
          latLng: LatLng(
            double.parse(place['lat']),
            double.parse(place['lon']),
          ),
        );
      }).toList();
      return locations;
    } else {
      throw Exception('Failed to search locations');
    }
  }

  @override
  LocationModel? mapResultToDelegateResult(dynamic result) {
    if (result == null) {
      return null;
    }
    return result as LocationModel;
  }
}
