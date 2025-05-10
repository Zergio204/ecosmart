import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  String? _token;
  String? _rol;

  String? get token => _token;
  String? get rol => _rol;

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/login'),
      body: {'email': email, 'contraseña': password},
    );
    final data = json.decode(response.body);
    _token = data['token'];
    _rol = data['rol'];
    notifyListeners();

    // Guardar en SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _token!);
    await prefs.setString('rol', _rol!);
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _rol = prefs.getString('rol');
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    _rol = null;
    notifyListeners();

    // Eliminar de SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('rol');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // ¡Acceder al token guardado!
  }
  
}