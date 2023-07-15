import 'package:flutter/material.dart';

class AirportNavigationScreen extends StatefulWidget {
  @override
  _AirportNavigationScreenState createState() => _AirportNavigationScreenState();
}

class _AirportNavigationScreenState extends State<AirportNavigationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Perform further actions with the entered flight information
    // For example, you can pre-request a driver for pickup on the date of the flight
    // preRequestDriver(airline, departureDate, arrivalDate, airportLocation, terminalNumber);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('User Airport Navigation'),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Flight', icon: Icon(Icons.flight)),
              Tab(text: 'Train', icon: Icon(Icons.train)),
              Tab(text: 'Bus',  icon: Icon(Icons.directions_bus)),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildFlightTab(),
            _buildTrainTab(),
            _buildBusTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightTab() {
    String airline = '';
    String departureDate = '';
    String arrivalDate = '';
    String airportLocation = '';
    String terminalNumber = '';

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Airline'),
            onChanged: (value) {
              setState(() {
                airline = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(labelText: 'Departure Date'),
            onChanged: (value) {
              setState(() {
                departureDate = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(labelText: 'Arrival Date'),
            onChanged: (value) {
              setState(() {
                arrivalDate = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(labelText: 'Airport Location'),
            onChanged: (value) {
              setState(() {
                airportLocation = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(labelText: 'Terminal Number'),
            onChanged: (value) {
              setState(() {
                terminalNumber = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              _submitForm();
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildTrainTab() {
    String trainCompany = '';
    String departureDate = '';
    String arrivalDate = '';
    String trainStation = '';
    String platformNumber = '';

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Train Company'),
            onChanged: (value) {
              setState(() {
                trainCompany = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(labelText: 'Departure Date'),
            onChanged: (value) {
              setState(() {
                departureDate = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(labelText: 'Arrival Date'),
            onChanged: (value) {
              setState(() {
                arrivalDate = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(labelText: 'Train Station'),
            onChanged: (value) {
              setState(() {
                trainStation = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(labelText: 'Platform Number'),
            onChanged: (value) {
              setState(() {
                platformNumber = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              _submitForm();
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildBusTab() {
    String busCompany = '';
    String departureDate = '';
    String arrivalDate = '';
    String busStation = '';
    String busNumber = '';

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Bus Company'),
            onChanged: (value) {
              setState(() {
                busCompany = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(labelText: 'Departure Date'),
            onChanged: (value) {
              setState(() {
                departureDate = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(labelText: 'Arrival Date'),
            onChanged: (value) {
              setState(() {
                arrivalDate = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(labelText: 'Bus Station'),
            onChanged: (value) {
              setState(() {
                busStation = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(labelText: 'Bus Number'),
            onChanged: (value) {
              setState(() {
                busNumber = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              _submitForm();
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}