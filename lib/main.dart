import 'package:flutter/material.dart';
import 'package:flutter_project/screens/location_access_screen.dart';
import 'package:flutter_project/screens/user_safety_screen.dart';
import 'package:flutter_project/screens/accessibility_design_screen.dart';
import 'package:flutter_project/screens/airport_navigation_screen.dart';
import 'package:flutter_project/screens/generic_settings_screen.dart';
import 'package:flutter_project/screens/map_screen.dart';
import 'package:flutter_project/screens/signin_screen.dart';
import 'package:flutter_project/screens/feedback_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    MapScreen(),
    LocationAccessScreen(),
    UserSafetyScreen(),
    AccessibilityDesignScreen(),
    AirportNavigationScreen(),
    FeedbackScreen(),
    GenericSettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ra-pick',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => Scaffold(
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                label: 'Location',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.warning),
                label: 'Safety',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.accessibility),
                label: 'Accessibility',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.travel_explore),
                label: 'Trip',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.feedback_outlined),
                label: 'Feedback',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
          ),
        ),
      },
    );
  }
}