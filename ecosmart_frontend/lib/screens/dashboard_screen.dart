import 'package:flutter/material.dart';
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
  List<Contenedor> contenedores = [];
  bool isAdmin = false; // Variable para mostrar opciones de administrador

  @override
  void initState() {
    super.initState();
    _fetchContenedores();
  }

  Future<void> _fetchContenedores() async {
    try {
      final data = await _apiService.getContenedores();
      setState(() {
        contenedores = data;
        // Verificar si el usuario es administrador (ejemplo)
        isAdmin = true; // Reemplazar con lógica real
      });
    } catch (e) {
      print('Error al cargar contenedores: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('EcoSmart')),
      body: Column(
        children: [
          // Mapa con marcadores
          Expanded(
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
                  markers: contenedores.map((contenedor) {
                    final color = contenedor.nivelLlenado > 80
                        ? Colors.red
                        : contenedor.nivelLlenado > 50
                            ? Colors.orange
                            : Colors.green;

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
          SizedBox(height: 16),
          // Lista de contenedores
          Expanded(
            child: ListView.builder(
              itemCount: contenedores.length,
              itemBuilder: (context, index) {
                final contenedor = contenedores[index];
                final estadoColor = contenedor.estado == 'Recogido'
                    ? Colors.green
                    : Colors.yellow;

                return Card(
                  child: ListTile(
                    title: Text('Contenedor ${contenedor.id}'),
                    subtitle: Text(contenedor.ubicacion ?? 'Ubicación no disponible'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/container-detail',
                          arguments: contenedor.id,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: estadoColor,
                      ),
                      child: Text('Ver detalles'),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          // Gráfico de predicciones (solo para admins)
          if (isAdmin)
            Column(
              children: [
                Text('Gráfico de predicciones'),
                // Aquí puedes agregar un widget como charts_flutter
              ],
            ),
          SizedBox(height: 16),
          // Botones de acción
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/rutas'),
                child: Text('Rutas programadas'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/configurar-umbrales'),
                child: Text('Configurar umbrales'),
              ),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/create-container'),
            child: Text('Añadir nuevo contenedor'),
          ),
        ],
      ),
    );
  }
}