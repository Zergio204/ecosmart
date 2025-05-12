// lib/models/ruta.dart
import 'package:ecosmart_frontend/models/contenedor.dart';

class Ruta {
  final int id;
  final String fecha;
  final String estado;
  final double distanciaKm;
  final int duracionMin;
  final List<Contenedor> contenedores;

  Ruta({
    required this.id,
    required this.fecha,
    required this.estado,
    required this.distanciaKm,
    required this.duracionMin,
    required this.contenedores,
  });

  static List<Ruta> fromList(List<dynamic> list) {
    return list.map((json) => Ruta.fromJson(json)).toList();
  }

  factory Ruta.fromJson(Map<String, dynamic> json) {
    return Ruta(
      id: json['id'],
      fecha: json['fecha'],
      estado: json['estado'],
      distanciaKm: json['distancia_km']?.toDouble() ?? 0,
      duracionMin: json['duracion_min'] ?? 0,
      contenedores: (json['contenedores'] as List)
          .map((e) => Contenedor.fromJson(e))
          .toList(),
    );
  }
}