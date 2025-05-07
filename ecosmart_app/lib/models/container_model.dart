import 'time_series_sales.dart'; // Importar la nueva clase

class ContainerModel {
  final int id;
  final String ubicacion;
  final double lat;
  final double lng;
  final int nivelLlenado;
  final List<TimeSeriesSales>? prediccion; // Usar el tipo correcto

  ContainerModel({
    required this.id,
    required this.ubicacion,
    required this.lat,
    required this.lng,
    required this.nivelLlenado,
    this.prediccion,
  });

  // Método para convertir JSON a ContainerModel
  factory ContainerModel.fromJson(Map<String, dynamic> json) {
    return ContainerModel(
      id: json['id'],
      ubicacion: json['ubicacion'],
      lat: json['lat'],
      lng: json['lng'],
      nivelLlenado: json['nivel_llenado'],
      prediccion: (json['prediccion'] as List<dynamic>?)
          ?.map((e) => TimeSeriesSales.fromJson(e))
          .toList(),
    );
  }
}