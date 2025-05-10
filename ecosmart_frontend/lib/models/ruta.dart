import '../models/contenedor.dart';

class Ruta {
  final int id;
  final int idOperario;
  final double distanciaKm;
  final int duracionMin;
  final List<Contenedor> contenedores;

  Ruta({
    required this.id,
    required this.idOperario,
    required this.distanciaKm,
    required this.duracionMin,
    required this.contenedores,
  });

  factory Ruta.fromJson(Map<String, dynamic> json) {
    return Ruta(
      id: json['id'],
      idOperario: json['id_operario'],
      distanciaKm: json['distancia_km'],
      duracionMin: json['duracion_min'],
      contenedores: Contenedor.fromList(json['contenedores'] ?? []),
    );
  }

  static List<Ruta> fromList(List<dynamic> list) {
    return list.map((e) => Ruta.fromJson(e)).toList();
  }
}