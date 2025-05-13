// lib/screens/ruta_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/api_service.dart';
import '../models/ruta.dart';

class RutaDetailScreen extends StatefulWidget { // ¡Clase correctamente definida!
  final int rutaId;
  const RutaDetailScreen({required this.rutaId});

  @override
  _RutaDetailScreenState createState() => _RutaDetailScreenState();
}

class _RutaDetailScreenState extends State<RutaDetailScreen> {
  late Future<Ruta> _futureRuta;

  @override
  void initState() {
    super.initState();
    _futureRuta = ApiService().getRuta(widget.rutaId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalles de la Ruta ${widget.rutaId}')),
      body: FutureBuilder<Ruta>(
        future: _futureRuta,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.contenedores.isEmpty) {
            return Center(child: Text('No hay datos disponibles'));
          }
          final ruta = snapshot.data!;
          return Column(
            children: [
              // Mapa con marcadores
              FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(
                    ruta.contenedores.first.lat ?? 41.65,
                    ruta.contenedores.first.lng ?? -4.72,
                  ),
                  initialZoom: 13,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: ruta.contenedores.map((contenedor) {
                      return Marker(
                        point: LatLng(contenedor.lat ?? 0, contenedor.lng ?? 0),
                        width: 40,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(child: Text(contenedor.id.toString())),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              // ... resto de la UI ...
            ],
          );
        },
      ),
    );
  }
}