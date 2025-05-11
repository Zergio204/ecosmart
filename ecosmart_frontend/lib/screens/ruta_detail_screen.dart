// lib/screens/ruta_detail_screen.dart
/*import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/api_service.dart';
import '../models/ruta.dart';

class RutaDetailScreen extends StatefulWidget {
  final int rutaId;

  RutaDetailScreen({required this.rutaId});

  @override
  _RutaDetailScreenState createState() => _RutaDetailScreenState();
}

class _RutaDetailScreenState extends State<RutaDetailScreen> {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ruta ${widget.rutaId}'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Lógica para menú lateral
            },
          ),
        ],
      ),
      body: FutureBuilder<Ruta>(
        future: _apiService.getRuta(widget.rutaId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: Text('Ruta no encontrada'));
          }

          final ruta = snapshot.data!;

          return ListView(
            children: [
              // Mapa interactivo
              FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(41.65, -4.72), // Coordenadas por defecto (Valladolid)
                  initialZoom: 13, // Nivel de zoom inicial
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: ruta.contenedores.map<Marker>((contenedor) {
                      return Marker(
                        point: LatLng(contenedor.lat!, contenedor.lng!),
                        width: 40,
                        height: 40,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/contenedor-detail', arguments: contenedor.id);
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.delete,
                                color: contenedor.nivelLlenado > 80 ? Colors.red : Colors.green,
                                size: 40,
                              ),
                              Text(
                                '${contenedor.id}',
                                style: TextStyle(
                                  color: contenedor.nivelLlenado > 80 ? Colors.red : Colors.black,
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

              // Información de la ruta
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${ruta.fecha}'),
                        Text('${ruta.duracionMin}'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${ruta.distanciaKm} km'),
                        Text('${ruta.contenedores.length} Contenedores'),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Botones de acción
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Lógica para guardar cambios en la ruta
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
          );
        },
      ),
    );
  }
}*/