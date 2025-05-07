import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const _baseUrl = 'http://localhost:3000/api';
  static const _storage = FlutterSecureStorage();

  static Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      body: {'email': email, 'password': password}
    );

    if (response.statusCode == 200) {
      await _storage.write(key: 'token', value: json.decode(response.body)['token']);
      return true;
    }
    return false;
  }

  static Future<bool> register(
    String nombre,
    String email,
    String password,
    String rol
  ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/registro'),
      body: {
        'nombre': nombre,
        'email': email,
        'contraseña': password,
        'rol': rol
      }
    );

    return response.statusCode == 201;
  }

  static Future<String?> getUserRole() async {
    return await _storage.read(key: 'user_role');
  }


  static Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }
  
}