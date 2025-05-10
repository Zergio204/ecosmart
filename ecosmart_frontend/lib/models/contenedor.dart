// models/contenedor.dart
class Contenedor {
  final int id;
  final String ubicacion;
  final int capacidadMax;
  final int nivelLlenado;
  final int umbralCritico;
  final double? lat;
  final double? lng;
  String? estado;

  Contenedor({
    required this.id,
    required this.ubicacion,
    required this.capacidadMax,
    required this.nivelLlenado,
    required this.umbralCritico,
    this.lat,
    this.lng,
    required this.estado,
  });

  factory Contenedor.fromJson(Map<String, dynamic> json) {
    return Contenedor(
      id: json['id'],
      ubicacion: json['ubicacion'],
      capacidadMax: json['capacidad_max'],
      nivelLlenado: json['nivel_llenado'],
      umbralCritico: json['umbral_critico'],
      lat: json['lat']?.toDouble(),
      lng: json['lng']?.toDouble(),
      estado: json['estado'] ?? 'Pendiente',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ubicacion': ubicacion,
      'capacidad_max': capacidadMax,
      'nivel_llenado': nivelLlenado,
      'umbral_critico': umbralCritico,
      'lat': lat,
      'lng': lng,
      'estado': estado,
    };
  }

  static List<Contenedor> fromList(List<dynamic> list) {
    return list.map((e) => Contenedor.fromJson(e)).toList();
  }
  
}