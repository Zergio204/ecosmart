class Emergencia {
  final int id;
  final int idContenedor;
  final String descripcion;
  final String imagenUrl;

  Emergencia({
    required this.id,
    required this.idContenedor,
    required this.descripcion,
    required this.imagenUrl,
  });

  factory Emergencia.fromJson(Map<String, dynamic> json) {
    return Emergencia(
      id: json['id'],
      idContenedor: json['id_contenedor'],
      descripcion: json['descripcion'],
      imagenUrl: json['imagen_url'],
    );
  }

  static List<Emergencia> fromList(List<dynamic> list) {
    return list.map((e) => Emergencia.fromJson(e)).toList();
  }
}