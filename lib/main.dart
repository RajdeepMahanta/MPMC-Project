import 'package:flutter/material.dart';
import 'package:spotter/screens/login.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotter',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage(), // Set LoginPage as the home
    );
  }
}
