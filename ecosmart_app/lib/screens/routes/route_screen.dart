import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ecosmart_app/services/route_service.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({super.key});

  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  late GoogleMapController _mapController;
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _loadOptimalRoute();
  }

  Future<void> _loadOptimalRoute() async {
    final route = await RouteService.calculateOptimalRoute([1, 3, 5]);
    setState(() {
      _polylines.add(Polyline(
        polylineId: const PolylineId('optimal_route'),
        points: route.map((point) => LatLng(point.latitude, point.longitude)).toList(),
        color: Colors.blue,
        width: 5,
      ));
    });

    if (route.isNotEmpty) {
      _mapController.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(
            route.map((point) => point.latitude).reduce((a, b) => a < b ? a : b),
            route.map((point) => point.longitude).reduce((a, b) => a < b ? a : b),
          ),
          northeast: LatLng(
            route.map((point) => point.latitude).reduce((a, b) => a > b ? a : b),
            route.map((point) => point.longitude).reduce((a, b) => a > b ? a : b),
          ),
        ),
        50,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ruta Óptima')),
      body: GoogleMap(
        onMapCreated: (controller) => _mapController = controller,
        initialCameraPosition: const CameraPosition(
          target: LatLng(41.65, -4.72),
          zoom: 12,
        ),
        polylines: _polylines,
      ),
    );
  }
}