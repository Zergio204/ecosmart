import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteService {
  static const _baseUrl = 'http://localhost:3000/api';

  static Future<List<LatLng>> calculateOptimalRoute(List<int> containerIds) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/rutas/optima'),
      body: {'contenedores': containerIds.join(',')}
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['ruta'] as List<dynamic>)
          .map((point) => LatLng(point['lat'], point['lng']))
          .toList();
    }
    throw Exception('Error al calcular ruta');
  }
}