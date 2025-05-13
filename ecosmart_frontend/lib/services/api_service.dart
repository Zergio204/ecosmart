// lib/services/api_service.dart
import 'dart:convert';
import 'package:ecosmart_frontend/models/ruta.dart';
import 'package:http/http.dart' as http;
import '../models/usuario.dart';
import 'auth_service.dart';
import '../models/contenedor.dart';
import '../models/emergencia.dart';

class ApiService {
  final String _baseUrl = 'http://localhost:3000/api';

  // Registro de usuario
  Future<void> register(String nombre, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nombre': nombre,
          'email': email,
          'contraseña': password,
        }),
      );

      if (response.statusCode != 201) {
        throw Exception('Error al registrar usuario: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Login
  Future<Usuario> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'contraseña': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final usuario = Usuario.fromJson(data['usuario']);
      await AuthService().saveToken(data['token']);
      return usuario;
    } else {
      throw Exception('Error de autenticación: ${response.body}');
    }
  }

  // Método para enviar el código de verificación
  Future<void> sendVerificationCode(String email) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email}),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al enviar el código: ${response.body}');
    }
  }

  // Método para restablecer la contraseña
  Future<void> resetPassword(String email, String code, String newPassword) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'code': code,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al restablecer la contraseña: ${response.body}');
    }
  }

  // Crear un nuevo contenedor
  Future<void> createContenedor(Contenedor contenedor) async {
    try {
      final token = await AuthService().getToken(); // Obtener token de autenticación

      final response = await http.post(
        Uri.parse('$_baseUrl/contenedores'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Si el endpoint está protegido
        },
        body: json.encode(contenedor.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception('Error al crear el contenedor: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Obtener detalles de un contenedor
  Future<Contenedor> getContenedor(int id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/contenedores/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return Contenedor.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener los detalles del contenedor');
    }
  }

  // Obtener todos los contenedores
  Future<List<Contenedor>> getContenedores() async {
    final response = await http.get(Uri.parse('$_baseUrl/contenedores'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((json) => Contenedor.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los contenedores');
    }
  }

  // Obtener datos del usuario actual
  Future<Usuario> getUserData() async {
    final token = await AuthService().getToken();
    if (token == null) {
      throw Exception('No hay sesión iniciada');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/users/current'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return Usuario.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener los datos del usuario');
    }
  }

  // Actualizar perfil de usuario
  Future<void> updateUserProfile(String nombre, String email, String password) async {
    final token = await AuthService().getToken();
    final response = await http.put(
      Uri.parse('$_baseUrl/users/update'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'nombre': nombre,
        'email': email,
        'contraseña': password,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el perfil');
    }
  }

  Future<void> reportarEmergencia(int contenedorId, String descripcion, String imagenUrl) async {
    try {
      final token = await AuthService().getToken();
      await http.post(
        Uri.parse('$_baseUrl/emergencias'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'id_contenedor': contenedorId,
          'descripcion': descripcion,
          'imagen_url': imagenUrl,
        }),
      );
    } catch (e) {
      throw Exception('Error al reportar emergencia');
    }
  }

  // Obtener todas las emergencias
  Future<List<Emergencia>> getEmergencias() async {
    final token = await AuthService().getToken();
    final response = await http.get(
      Uri.parse('$_baseUrl/emergencias'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return Emergencia.fromList(json.decode(response.body));
    } else {
      throw Exception('Error al obtener emergencias');
    }
  }

 // Obtener todas las rutas
  Future<List<Ruta>> getRutas() async {
    try {
      final token = await AuthService().getToken();
      final response = await http.get(
        Uri.parse('http://localhost:3000/api/rutas'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Ruta.fromList(data ?? []);
      } else {
        throw Exception('Error al cargar las rutas');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Crear una nueva ruta
  Future<void> crearRuta(List<int> contenedorIds, String fecha, double duracion) async {
  try {
    final token = await AuthService().getToken();
    final response = await http.post(
      Uri.parse('$_baseUrl/rutas'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'id_operario': 1, // ID del operario actual
        'contenedorIds': contenedorIds,
        'fecha': fecha,
        'duracion_min': duracion.toInt(), // Convertir a entero
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al crear la ruta');
    }
  } catch (e) {
    throw Exception('Error de conexión: $e');
  }
}

  // Marcar contenedor como recogido
  Future<void> markCollected(int contenedorId) async {
    try {
      final token = await AuthService().getToken();
      final response = await http.put(
        Uri.parse('$_baseUrl/contenedores/$contenedorId/recogido'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        throw Exception('Error al marcar como recogido');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<Ruta> getRuta(int id) async {
  try {
    final token = await AuthService().getToken();
    final response = await http.get(
      Uri.parse('http://localhost:3000/api/rutas/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Ruta.fromJson(data); // ¡Verificar estructura!
    } else {
      throw Exception('Error al cargar la ruta');
    }
  } catch (e) {
    throw Exception('Error de conexión: $e');
  }
}

  Future<void> eliminarRuta(int id) async {
    try {
      final token = await AuthService().getToken();
      final response = await http.delete(
        Uri.parse('http://localhost:3000/api/rutas/$id'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        throw Exception('Error al eliminar la ruta');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<String> exportarDatos() async {
    try {
      final token = await AuthService().getToken();
      final response = await http.get(
        Uri.parse('http://localhost:3000/api/export-data'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        return response.body; // Devuelve los datos en formato CSV/JSON
      } else {
        throw Exception('Error al exportar datos');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
  
}
