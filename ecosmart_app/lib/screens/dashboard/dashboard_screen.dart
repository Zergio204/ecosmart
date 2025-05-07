import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ecosmart_app/services/container_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadContainers();
  }

  Future<void> _loadContainers() async {
    final containers = await ContainerService.getContainers();
    setState(() {
      _markers.addAll(
        containers.map((container) => Marker(
          markerId: MarkerId(container.id.toString()),
          position: LatLng(container.lat, container.lng),
          infoWindow: InfoWindow(title: container.ubicacion),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            container.nivelLlenado > 80 ? BitmapDescriptor.hueRed : 
            container.nivelLlenado > 50 ? BitmapDescriptor.hueOrange : 
            BitmapDescriptor.hueGreen
          )
        ))
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => _mapController = controller,
            initialCameraPosition: const CameraPosition(
              target: LatLng(41.65, -4.72), // Coordenadas de Valladolid
              zoom: 12,
            ),
            markers: _markers,
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                _mapController.animateCamera(
                  CameraUpdate.newLatLng(const LatLng(41.65, -4.72)),
                );
              },
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}