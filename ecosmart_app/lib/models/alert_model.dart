class Alert {
  final int id;
  final int containerId;
  final int threshold;
  final DateTime dateTime;
  final String status;

  Alert({
    required this.id,
    required this.containerId,
    required this.threshold,
    required this.dateTime,
    required this.status,
  });

  // Convertir JSON a objeto Alert
  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      id: json['id'],
      containerId: json['id_contenedor'],
      threshold: json['umbral'],
      dateTime: DateTime.parse(json['fecha_hora']),
      status: json['estado'],
    );
  }
}