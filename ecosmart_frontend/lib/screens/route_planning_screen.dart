// lib/screens/route_planning_screen.dart
/*import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/api_service.dart';
import '../models/contenedor.dart';

class RoutePlanningScreen extends StatefulWidget {
  final List<Contenedor> contenedores;

  RoutePlanningScreen({required this.contenedores});

  @override
  _RoutePlanningScreenState createState() => _RoutePlanningScreenState();
}

class _RoutePlanningScreenState extends State<RoutePlanningScreen> {
  final ApiService _apiService = ApiService();

  bool isRouteStarted = false;
  int collectedCount = 0;

  Future<void> _markCollected(Contenedor contenedor) async {
    try {
      await _apiService.markCollected(contenedor.id);
      setState(() {
        contenedor.estado = 'Recogido'; // Actualizar el estado localmente
        collectedCount++;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al marcar como recogido')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planificación de Ruta'),
      ),
      body: ListView(
        children: [
          // Mapa interactivo
          FlutterMap(
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
                markers: widget.contenedores.map<Marker>((contenedor) {
                  return Marker(
                    point: LatLng(contenedor.lat ?? 41.65, contenedor.lng ?? -4.72),
                    width: 40,
                    height: 40,
                    child: GestureDetector(
                      onTap: () {
                        _markCollected(contenedor); // Marcar como recogido
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.delete,
                            color: contenedor.estado == 'Recogido' ? Colors.green : Colors.red,
                            size: 40,
                          ),
                          Text('${contenedor.id}'),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // Lista de contenedores
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.contenedores.length,
            itemBuilder: (context, index) {
              final contenedor = widget.contenedores[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Contenedor ${contenedor.id}'),
                  subtitle: Text(contenedor.ubicacion),
                  trailing: ElevatedButton(
                    onPressed: () {
                      _markCollected(contenedor); // Marcar como recogido
                    },
                    child: Text(contenedor.estado == 'Recogido' ? 'Recogido' : 'Marcar Recogido'),
                  ),
                ),
              );
            },
          ),

          // Resumen de la ruta
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Resumen de la Ruta'),
                SizedBox(height: 16),

                // Información del resumen
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Distancia total: 5 km'),
                    Text('Duración estimada: 45 minutos'),
                    Text('Contenedores a visitar: $collectedCount de ${widget.contenedores.length}'),
                  ],
                ),
                SizedBox(height: 16),

                // Botón Iniciar Recorrido
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isRouteStarted = true;
                    });
                  },
                  child: Text('Iniciar Recorrido'),
                ),
                SizedBox(height: 16),

                // Barra de progreso
                LinearProgressIndicator(
                  value: collectedCount / widget.contenedores.length,
                ),
                SizedBox(height: 16),

                // Botón Reportar Emergencia
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/report-emergency');
                  },
                  child: Text('Reportar Emergencia'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/