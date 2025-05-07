import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteModel {
  final List<LatLng> points;
  final double distance;
  final int duration;

  RouteModel({
    required this.points,
    required this.distance,
    required this.duration,
  });
}