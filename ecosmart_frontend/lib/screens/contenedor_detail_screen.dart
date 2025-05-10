// lib/screens/contenedor_detail_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/contenedor.dart';

class ContenedorDetailScreen extends StatefulWidget {
  final int contenedorId;

  ContenedorDetailScreen({required this.contenedorId});

  @override
  _ContenedorDetailScreenState createState() => _ContenedorDetailScreenState();
}

class _ContenedorDetailScreenState extends State<ContenedorDetailScreen> {
  final ApiService _apiService = ApiService();

  Contenedor? contenedor;
  double nivelLlenado = 0.0; // Nivel de llenado inicial

  @override
  void initState() {
    super.initState();
    _fetchContenedorDetails();
  }

  Future<void> _fetchContenedorDetails() async {
    try {
      final fetchedContenedor = await _apiService.getContenedor(widget.contenedorId);
      setState(() {
        contenedor = fetchedContenedor;
        nivelLlenado = fetchedContenedor.nivelLlenado.toDouble();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar los detalles del contenedor')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (contenedor == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Contenedor #${contenedor!.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contenedor!.ubicacion,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Barra de progreso del nivel de llenado
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: nivelLlenado / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      nivelLlenado > 80 ? Colors.red : Colors.green,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text('${nivelLlenado.toStringAsFixed(0)} %'),
              ],
            ),
            SizedBox(height: 16),

            // Gráfico de evolución
            Text('Evolución Nivel de Llenado'),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Lógica para mostrar evolución diaria
                  },
                  child: Text('Evolución diaria'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para mostrar evolución semanal
                  },
                  child: Text('Evolución semanal'),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Sliders para configurar umbrales
            Text('Botón Umbral: Sliders para configurar los umbrales de vacío, medio y lleno'),
            Slider(
              min: 0.0,
              max: 100.0,
              value: nivelLlenado,
              onChanged: (value) {
                setState(() {
                  nivelLlenado = value;
                });
              },
            ),
            SizedBox(height: 16),

            // Botones de acción
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Lógica para configurar umbrales
                  },
                  child: Text('Configurar Umbral'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Redirige a la historia de alertas
                  },
                  child: Text('Ver Alertas'),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Botón para ver en el mapa
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              child: Text('Ver en el Mapa'),
            ),
          ],
        ),
      ),
    );
  }
}