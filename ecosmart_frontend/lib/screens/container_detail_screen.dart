import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/contenedor.dart';

class ContainerDetailScreen extends StatefulWidget {
  final int contenedorId;
  ContainerDetailScreen({required this.contenedorId});

  @override
  _ContainerDetailScreenState createState() => _ContainerDetailScreenState();
}

class _ContainerDetailScreenState extends State<ContainerDetailScreen> {
  late Future<Contenedor> _futureContenedor;

  @override
  void initState() {
    super.initState();
    _futureContenedor = ApiService().getContenedor(widget.contenedorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalles del Contenedor')),
      body: FutureBuilder<Contenedor>(
        future: _futureContenedor,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final contenedor = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Contenedor #${contenedor.id}'),
                Text(contenedor.ubicacion ?? 'Ubicación no disponible'),
                SizedBox(height: 16),

                // Barra de progreso
                LinearProgressIndicator(
                  value: contenedor.nivelLlenado / contenedor.capacidadMax,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    contenedor.nivelLlenado > contenedor.umbralCritico ? Colors.red : Colors.green,
                  ),
                ),
                SizedBox(height: 8),
                Text('${(contenedor.nivelLlenado / contenedor.capacidadMax * 100).toStringAsFixed(0)}%'),

                // Botones
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/configurar-umbrales'),
                  child: Text('Configurar Umbrales'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/ver-alertas'),
                  child: Text('Ver Alertas'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}