import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:mapbox_line_route/core/const.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class LineScreenMapBox extends StatefulWidget {
  final LatLng? destination;
  const LineScreenMapBox({super.key, this.destination});

  @override
  State<LineScreenMapBox> createState() => _LineScreenMapBoxState();
}

class _LineScreenMapBoxState extends State<LineScreenMapBox> {

  late LatLng startPoint;
  late List<LatLng> routeCoordinates = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

//==============================================================================
  Future<void> _getCurrentLocation() async {
    final geolocator = GeolocatorPlatform.instance;

    try {
      Position position = await geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      if (mounted) {
        setState(() {
          cPosition = position;
          startPoint = LatLng(position.latitude, position.longitude);
          getRoutes();
        });
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  ///===========================================================================
  ///Decodifica la respuesta de la API de Mapbox
  Future<List<LatLng>> _decodeRoute(String responseBody) async {
    //se utiliza para almacenar las coordenadas de la ruta que se extraera de la respuesta.
    List<LatLng> route = [];

    final Map<String, dynamic> data = json.decode(responseBody);
    final List<dynamic> routes = data['routes'];
    if (routes.isNotEmpty) {
      final List<dynamic> legs = routes[0]['legs'];
      for (final leg in legs) {
        final List<dynamic> steps = leg['steps'];
        for (final step in steps) {
          final geometry = step['geometry'];
          if (geometry != null && geometry is String) {
            List<PointLatLng> decodedPolyline = PolylinePoints().decodePolyline(geometry);
            for (PointLatLng point in decodedPolyline) {
              route.add(LatLng(point.latitude, point.longitude));
            }
          }
        }
      }
    }
    return route;
  }

  ///===========================================================================

  ///Esta se encarga de obtener las rutas desde un punto de inicio hasta un destino
  ///utilizando la API
  Future<void> getRoutes() async {
    http.Response response = await http.get(Uri.parse(
        '$urlDriving${startPoint.longitude},${startPoint.latitude};${widget.destination!.longitude},${widget.destination!.latitude}?steps=true&alternatives=false&access_token=<access_token_publico_mapbox>'));
    if (response.statusCode == 200 && mounted) {
      List<LatLng> route = await _decodeRoute(response.body);
      if (mounted) {
        setState(() {
          routeCoordinates = route;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Map diretions',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0XFF0f2b2d),
      ),
      body: routeCoordinates.isEmpty
          ? const Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      )
          : FlutterMap(
        options: MapOptions(
          initialCenter: startPoint,
          initialZoom: 14.0,
        ),
        children: [
          TileLayer(
            urlTemplate: urlTemplate,
            additionalOptions: {'accessToken': '<access_token_public_mapbox>'},
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: routeCoordinates,
                color: Colors.blue,
                strokeWidth: 4,
              ),
            ],
          ),
          MarkerLayer(
            markers: [
              Marker(
                  width: 40.0,
                  height: 40.0,
                  point: startPoint,
                  child: const Icon(
                    Icons.person_pin_circle,
                    color: Color(0XFF0f2b2d),
                    size: 50.0,
                  ),
                  alignment: Alignment.center),
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(widget.destination!.latitude, widget.destination!.longitude),
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 50.0,
                ),
                alignment: Alignment.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
