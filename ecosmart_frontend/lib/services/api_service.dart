// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/usuario.dart';
import 'auth_service.dart';

class ApiService {
  final String _baseUrl = 'http://localhost:3000/api';

  // Registro de usuario
  Future<void> register(String nombre, String email, String password, String rol) async {
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

}