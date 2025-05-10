// lib/screens/routes_screen.dart
import 'package:flutter/material.dart';
import '../models/ruta.dart';
import '../services/api_service.dart';

class RoutesScreen extends StatefulWidget {
  @override
  _RoutesScreenState createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EcoSmart'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Lógica para búsqueda avanzada
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Ruta>>(
        future: _apiService.getRutas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay rutas registradas'));
          }

          final rutas = snapshot.data!;

          return Column(
            children: [
              // Barra de búsqueda y filtros
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Buscar',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {
                        // Lógica para filtrado avanzado
                      },
                    ),
                  ],
                ),
              ),

              // Lista de rutas
              Expanded(
                child: ListView.builder(
                  itemCount: rutas.length,
                  itemBuilder: (context, index) {
                    final ruta = rutas[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        leading: Icon(Icons.info),
                        title: Text('Ruta ${ruta.id}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${ruta.fecha} ${ruta.duracionMin}'),
                            Text('${ruta.contenedores.length} Contenedores'),
                            Text('${ruta.distanciaKm} km'),
                          ],
                        ),
                        trailing: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/ruta-detail', arguments: ruta.id);
                              },
                              child: Text('Ver Detalles'),
                            ),
                            SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                // Lógica para eliminar ruta
                              },
                              child: Text('Eliminar Ruta'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Botón para crear nueva ruta
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/crear-ruta');
                  },
                  child: Text('Crear Nueva Ruta'),
                ),
              ),

              // Resumen de rutas
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Resumen de Rutas'),
                    SizedBox(height: 8),

                    // Progreso de rutas pendientes
                    Row(
                      children: [
                        Text('Pendientes'),
                        SizedBox(width: 8),
                        LinearProgressIndicator(
                          value: 0.7, // Ejemplo de progreso
                          backgroundColor: Colors.yellow[700],
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

                    // Progreso de rutas en curso
                    Row(
                      children: [
                        Text('En Curso'),
                        SizedBox(width: 8),
                        LinearProgressIndicator(
                          value: 0.5, // Ejemplo de progreso
                          backgroundColor: Colors.purple[700],
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

                    // Progreso de rutas completadas
                    Row(
                      children: [
                        Text('Completadas'),
                        SizedBox(width: 8),
                        LinearProgressIndicator(
                          value: 0.9, // Ejemplo de progreso
                          backgroundColor: Colors.green[700],
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreenAccent),
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
}