class Alerta {
  final int id;
  final int idContenedor;
  final int umbral;
  final String estado;

  Alerta({
    required this.id,
    required this.idContenedor,
    required this.umbral,
    required this.estado,
  });

  factory Alerta.fromJson(Map<String, dynamic> json) {
    return Alerta(
      id: json['id'],
      idContenedor: json['id_contenedor'],
      umbral: json['umbral'],
      estado: json['estado'],
    );
  }

  static List<Alerta> fromList(List<dynamic> list) {
    return list.map((e) => Alerta.fromJson(e)).toList();
  }
}