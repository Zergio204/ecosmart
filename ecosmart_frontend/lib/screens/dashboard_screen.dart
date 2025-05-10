// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/api_service.dart';
import '../models/contenedor.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de Contenedores'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/contenedor-create'),
          )
        ],
      ),
      body: FutureBuilder<List<Contenedor>>(
        future: ApiService().getContenedores(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay contenedores registrados'));
          }

          // Crear marcadores
          final markers = snapshot.data!.map((contenedor) {
            return Marker(
              point: LatLng(
                contenedor.lat ?? 41.65, // Coordenadas por defecto si son NULL
                contenedor.lng ?? -4.72,
              ),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/contenedor-detail',
                  arguments: contenedor.id,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete,
                      color: contenedor.nivelLlenado > 80 ? Colors.red : Colors.green,
                      size: 40,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${contenedor.nivelLlenado}%',
                      style: TextStyle(
                        color: contenedor.nivelLlenado > 80 ? Colors.red : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList();

          return FlutterMap(
            options: MapOptions(
                initialCenter: LatLng(41.65, -4.72), // Coordenadas de Valladolid
                initialZoom: 13,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: markers, // ¡Variable correctamente definida!
              ),
            ],
          );
        },
      ),
    );
  }
}