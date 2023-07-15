import 'package:flutter/material.dart';

class UserSafetyScreen extends StatefulWidget {
  @override
  _UserSafetyScreenState createState() => _UserSafetyScreenState();
}

class _UserSafetyScreenState extends State<UserSafetyScreen> {
  bool isHoldingScreen = false;
  int holdDuration = 5; // Duration in seconds

  void _startHoldTimer() {
    setState(() {
      isHoldingScreen = true;
    });

    Future.delayed(Duration(seconds: holdDuration), () {
      if (isHoldingScreen) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Emergency Call'),
              content: Text('Do you want to call 911 for help?'),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    setState(() {
                      isHoldingScreen = false;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Call 911'),
                  onPressed: () {
                    // Perform the emergency call
                    // callEmergency();
                    setState(() {
                      isHoldingScreen = false;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _stopHoldTimer() {
    setState(() {
      isHoldingScreen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Safety Fail Safe'),
      ),
      body: GestureDetector(
        onTapDown: (_) {
          _startHoldTimer();
        },
        onTapUp: (_) {
          _stopHoldTimer();
        },
        onTapCancel: () {
          _stopHoldTimer();
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning,
                size: 100.0,
                color: isHoldingScreen ? Colors.red : Colors.grey,
              ),
              SizedBox(height: 16.0),
              Text(
                'Hold the screen for $holdDuration seconds to trigger emergency call',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}