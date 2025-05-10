import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/ruta.dart';

class RutasScreen extends StatelessWidget {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rutas de Recogida')),
      body: FutureBuilder<List<Ruta>>(
        future: _apiService.getRutas(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final ruta = snapshot.data![index];
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text('Ruta ${ruta.id}'),
                        Text('Operario: ${ruta.idOperario}'),
                        Text('Distancia: ${ruta.distanciaKm} km'),
                        Text('Duración: ${ruta.duracionMin} min'),
                        ElevatedButton(
                          onPressed: () {
                            // Navegar a detalles de la ruta
                          },
                          child: Text('Ver Contenedores'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}