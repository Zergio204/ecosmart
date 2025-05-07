import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/container_model.dart';

class ContainerService {
  static const _baseUrl = 'http://localhost:3000/api';

  static Future<List<ContainerModel>> getContainers() async {
    final response = await http.get(Uri.parse('$_baseUrl/contenedores'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ContainerModel.fromJson(json)).toList();
    }
    throw Exception('Error al cargar contenedores');
  }

  static Future<void> updateThresholds(int critical, int warning) async {
    await http.post(
      Uri.parse('$_baseUrl/config/umbrales'),
      body: {'critico': critical.toString(), 'advertencia': warning.toString()}
    );
  }
}