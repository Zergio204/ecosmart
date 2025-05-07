class UserModel {
  final int id;
  final String nombre;
  final String email;
  final String rol; // 'admin', 'operario', 'ciudadano'
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.nombre,
    required this.email,
    required this.rol,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convertir JSON a UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      rol: json['rol'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}