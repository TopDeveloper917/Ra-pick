import 'package:flutter/material.dart';
import 'package:flutter_project/models/location.dart';
import 'package:flutter_project/screens/components/location_search_delegate.dart';

class LocationTextField extends StatelessWidget {
  final LocationModel? location;
  final TextEditingController controller;
  final String labelText;
  final Function(LocationModel?) onLocationSelected;

  const LocationTextField({
    Key? key,
    this.location,
    required this.controller,
    required this.labelText,
    required this.onLocationSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Enter a location',
        suffixIcon: Icon(Icons.search),
        labelText: labelText,
      ),
      controller: controller,
      onTap: () async {
        final selectedLocation = await showSearch<LocationModel?>(
          context: context,
          delegate: LocationSearchDelegate(),
        );
        onLocationSelected(selectedLocation);
      },
    );
  }
}