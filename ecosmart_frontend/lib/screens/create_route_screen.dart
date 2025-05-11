// lib/screens/create_route_screen.dart
/*import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/api_service.dart';

class CreateRouteScreen extends StatefulWidget {
  @override
  _CreateRouteScreenState createState() => _CreateRouteScreenState();
}

class _CreateRouteScreenState extends State<CreateRouteScreen> {
  final ApiService _apiService = ApiService();

  // Datos de la nueva ruta
  final List<LatLng> selectedPoints = []; // Puntos seleccionados en el mapa
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Ruta'),
      ),
      body: ListView(
        children: [
          // Mapa interactivo
          Container(
            height: 300, // ✅ Altura definida
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(41.65, -4.72),
                initialZoom: 13,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: selectedPoints.map((point) {
                  return Marker(
                    point: point,
                    width: 40,
                    height: 40,
                    child: GestureDetector(
                      onTap: () {
                        // Lógica para eliminar el marcador si es necesario
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 40,
                          ),
                          Text(
                            '${selectedPoints.indexOf(point) + 1}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

          // Formulario de detalles de la ruta
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Fecha de realización:'),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                          hintText: 'xx/xx/xxxx',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text('Hora de comienzo:'),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: timeController,
                        decoration: InputDecoration(
                          hintText: 'xx:xx',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // Botones de acción
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para guardar la nueva ruta
                      },
                      child: Text('Guardar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Volver a la pantalla anterior
                      },
                      child: Text('Volver'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/