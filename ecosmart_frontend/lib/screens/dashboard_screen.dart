// lib/screens/dashboard_screen.dart
/*import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/api_service.dart';
import '../models/contenedor.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EcoSmart'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Lógica para menú lateralt
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Contenedor>>(
        future: _apiService.getContenedores(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final contenedores = snapshot.data ?? [];

          // Filtrar contenedores con coordenadas válidas
          final contenedoresConCoordenadas = contenedores.where((contenedor) {
            return contenedor.lat != null && contenedor.lng != null;
          }).toList();

          return ListView(
            children: [
              // Mapa interactivo
              Container(
                height: 300, // Fija una altura para que el mapa se vea bien
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(41.65, -4.72), // Valladolid por defecto
                    initialZoom: 13,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: contenedoresConCoordenadas.map<Marker>((contenedor) {
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
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // Mensaje debajo del mapa si no hay contenedores
              if (contenedores.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'No hay contenedores registrados',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),

              // Listado de contenedores (funciona aunque esté vacío)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: contenedores.length,
                itemBuilder: (context, index) {
                  final contenedor = contenedores[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text('Contenedor ${contenedor.id}'),
                      subtitle: Text(contenedor.ubicacion ?? 'Ubicación no disponible'),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/contenedor-detail', arguments: contenedor.id);
                        },
                        child: Text('Ver detalles'),
                      ),
                    ),
                  );
                },
              ),

              // Gráfico de predicciones (opcional para administradores)
              if (isAdministrator()) ...[
                SizedBox(height: 16),
                Text('Gráfico de predicciones'),
                // Aquí puedes agregar el gráfico usando un widget como charts_flutter
              ],

              // Opciones adicionales
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/route-planning');
                    },
                    child: Text('Rutas programadas'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                    child: Text('Configurar umbrales'),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/create-container');
                },
                child: Text('Añadir nuevo contenedor'),
              ),
            ],
          );
        },
      ),
    );
  }

  bool isAdministrator() {
    // Verificar si el usuario actual es administrador
    return true; // Reemplazar con lógica real
  }
}*/