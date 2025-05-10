class Contenedor {
  final int id;
  final String ubicacion;
  final int capacidadMax;
  final int nivelLlenado;
  final double? lat;
  final double? lng;
  final int umbralCritico;

  Contenedor({
    required this.id,
    required this.ubicacion,
    required this.capacidadMax,
    required this.nivelLlenado,
    this.lat,
    this.lng,
    required this.umbralCritico,
  });

  factory Contenedor.fromJson(Map<String, dynamic> json) {
    return Contenedor(
      id: json['id'],
      ubicacion: json['ubicacion'],
      capacidadMax: json['capacidad_max'],
      nivelLlenado: json['nivel_llenado'],
      lat: json['lat']?.toDouble(),
      lng: json['lng']?.toDouble(),
      umbralCritico: json['umbral_critico'],
    );
  }

  static List<Contenedor> fromList(List<dynamic> list) {
    return list.map((e) => Contenedor.fromJson(e)).toList();
  }
  
}