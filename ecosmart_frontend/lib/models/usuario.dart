class Usuario {
  final int? id; // ID opcional para cuando se recibe desde el backend
  final String nombre;
  final String email;
  final String contrasenia; // Nota: En producción, nunca almacenes contraseñas en texto plano
  final String rol;

  Usuario({
    this.id,
    required this.nombre,
    required this.email,
    required this.contrasenia,
    this.rol = 'ciudadano', // Valor predeterminado
  });

  // Factory para crear un objeto Usuario desde JSON (backend)
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      contrasenia: json['contraseña'], // Solo para desarrollo, no usar en producción
      rol: json['rol'] ?? 'ciudadano',
    );
  }

  // Método para convertir el objeto Usuario a JSON (enviar al backend)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'contrasenia': contrasenia, // Solo para desarrollo, no usar en producción
      'rol': rol,
    };
  }
}