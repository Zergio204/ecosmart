import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/contenedor.dart';

class ContenedorDetailScreen extends StatelessWidget {
  final int contenedorId;

  ContenedorDetailScreen({required this.contenedorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalles del Contenedor')),
      body: FutureBuilder<Contenedor>(
        future: ApiService().getContenedor(contenedorId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final contenedor = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Ubicación: ${contenedor.ubicacion}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: contenedor.nivelLlenado / 100,
                    backgroundColor: Colors.grey[200],
                    color: contenedor.nivelLlenado > 80 ? Colors.red : Colors.green,
                  ),
                  Text('${contenedor.nivelLlenado}% lleno'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await ApiService().marcarRecogido(contenedor.id);
                      Navigator.pop(context);
                    },
                    child: Text('Marcar como Recogido'),
                  ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}