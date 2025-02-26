import 'package:flutter/material.dart';
import 'package:mapbox_line_route/screens/splash_screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MapBox',
      home: Splashscreen()
    );
  }
}
