import 'package:flutter/material.dart';
import 'package:spotter/screens/home.dart';
import 'package:spotter/screens/profile.dart';

void main() {
  runApp(SmartParkingApp());
}

class SmartParkingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Define routes for navigation
      routes: {
        '/': (context) => HomePage(),         // Home screen as the initial page
        '/profile': (context) => ProfilePage(), // Profile page route
      },
    );
  }
}
