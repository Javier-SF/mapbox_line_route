import 'package:flutter/material.dart';
import 'package:mapbox_line_route/core/utils/permission.dart';
import 'package:mapbox_line_route/core/screens/splash_screens.dart';

void main() async {
  await handleLocationPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'MapBox', home: Splashscreen());
  }
}
