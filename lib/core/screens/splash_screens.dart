import 'dart:async';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapbox_line_route/core/class/colors.dart';
import 'package:mapbox_line_route/core/screens/mapbox_line_route.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    initSplash(destination);
  }

  /// This here is a simulation as if we had a screen with the data, for example a list in which the
  /// data comes from an API and when touching a value in the list it does not redirect to our screen which will show the start and end path.
  List<LatLng> destination = [
    const LatLng(0.0, 0.0),
  ];

  void initSplash(List<LatLng> des) {
    for (var destination in des) {
      Timer(
        const Duration(seconds: 1),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LineScreenMapBox(destination: destination)),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LineGradinaP.primaryGradiant,
        ),
        child: const Center(
          child: FlutterLogo(
            size: 80,
            duration: Duration(seconds: 4),
            style: FlutterLogoStyle.markOnly,
          ),
        ),
      ),
    );
  }
}
