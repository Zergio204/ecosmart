import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/alert_model.dart';

class AlertService {
  static const _baseUrl = 'http://localhost:3000/api';

  static Future<List<Alert>> getAlerts() async {
    final response = await http.get(Uri.parse('$_baseUrl/alertas'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Alert.fromJson(json)).toList();
    }
    throw Exception('Error al cargar alertas');
  }

  static Future<void> markAsResolved(int alertId) async {
    await http.post(
      Uri.parse('$_baseUrl/alertas/$alertId/resolver'),
      body: {}
    );
  }

  static Future<void> reportEmergency(
    int containerId,
    String description,
    String? imagePath
  ) async {
    // Implementar lógica para subir imagen y reportar emergencia
  }
}