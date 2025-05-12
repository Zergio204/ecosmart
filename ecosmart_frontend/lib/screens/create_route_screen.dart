// lib/screens/create_route_screen.dart
import 'package:ecosmart_frontend/models/contenedor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/api_service.dart';

class CreateRouteScreen extends StatefulWidget {
  @override
  _CreateRouteScreenState createState() => _CreateRouteScreenState();
}

class _CreateRouteScreenState extends State<CreateRouteScreen> {
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();
  List<Contenedor> selectedContainers = [];

  void _selectContainer(LatLng position) {
  setState(() {
    selectedContainers.add(
      Contenedor(
        id: 0,
        ubicacion: 'Ubicación del contenedor',
        capacidadMax: 1000, 
        nivelLlenado: 0,
        umbralCritico: 80,
        lat: position.latitude,
        lng: position.longitude,
        estado: 'Pendiente',
      ),
    );
  });
}

  Future<void> _createRoute() async {
    if (_fechaController.text.isEmpty || _horaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, complete todos los campos')),
      );
      return;
    }

    try {
      await ApiService().crearRuta(
        selectedContainers.map((c) => c.id).toList(),
        _fechaController.text,
        double.parse(_horaController.text),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ruta creada exitosamente')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Nueva Ruta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 300,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(41.65, -4.72),
                  initialZoom: 13,
                  onTap: (tapPosition, point) {
                    _selectContainer(point);
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: selectedContainers.map((container) {
                      return Marker(
                        point: LatLng(container.lat!, container.lng!),
                        width: 40,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(child: Text(container.id.toString())),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _fechaController,
              decoration: InputDecoration(labelText: 'Fecha de realización'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _horaController,
              decoration: InputDecoration(labelText: 'Hora de comienzo'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _createRoute,
              child: Text('Guardar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}