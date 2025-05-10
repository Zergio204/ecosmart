import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import '../models/contenedor.dart';
import '../models/alerta.dart';
import '../models/emergencia.dart';
import '../models/ruta.dart';

class ApiService {
  static const String _baseUrl = 'http://localhost:3000/api';

  Future<Contenedor> getContenedor(int id) async {
    final token = await AuthService().getToken();
    final response = await http.get(
      Uri.parse('$_baseUrl/contenedores/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return Contenedor.fromJson(json.decode(response.body));
  }

  Future<List<Contenedor>> getContenedores() async {
    try {
      final token = await AuthService().getToken();
      final response = await http.get(
        Uri.parse('$_baseUrl/contenedores'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return Contenedor.fromList(json.decode(response.body));
      } else {
        throw Exception('Error al obtener contenedores');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<void> marcarRecogido(int id) async {
    final token = await AuthService().getToken();
    await http.post(
      Uri.parse('$_baseUrl/contenedores/$id/recoger'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Future<List<Alerta>> getAlertas() async {
    final token = await AuthService().getToken();
    final response = await http.get(
      Uri.parse('$_baseUrl/alertas'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return Alerta.fromList(json.decode(response.body));
  }

  Future<void> resolverAlerta(int alertaId) async {
    final token = await AuthService().getToken();
    await http.post(
      Uri.parse('$_baseUrl/alertas/$alertaId/resolver'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Future<void> crearRuta(List<int> contenedorIds) async {
    final token = await AuthService().getToken();
    await http.post(
      Uri.parse('$_baseUrl/rutas'),
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: json.encode({'id_operario': 1, 'contenedorIds': contenedorIds}),
    );
  }

  Future<List<Ruta>> getRutas() async {
    try {
      final token = await AuthService().getToken();
      final response = await http.get(
        Uri.parse('$_baseUrl/rutas'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return Ruta.fromList(json.decode(response.body));
      } else {
        throw Exception('Error al obtener rutas');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<List<Emergencia>> getEmergencias() async {
    final token = await AuthService().getToken();
    final response = await http.get(
      Uri.parse('$_baseUrl/emergencias'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return Emergencia.fromList(json.decode(response.body));
  }

  Future<void> reportarEmergencia(int contenedorId, String descripcion, String imagenUrl) async {
    final token = await AuthService().getToken();
    await http.post(
      Uri.parse('$_baseUrl/emergencias'),
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: json.encode({
        'id_contenedor': contenedorId,
        'descripcion': descripcion,
        'imagen_url': imagenUrl,
      }),
    );
  }

  Future<Map<String, dynamic>> getConfigUmbrales() async {
    final token = await AuthService().getToken();
    final response = await http.get(
      Uri.parse('$_baseUrl/config/umbrales'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return json.decode(response.body);
  }

  Future<void> updateConfigUmbrales(int critico, int advertencia) async {
    final token = await AuthService().getToken();
    await http.post(
      Uri.parse('$_baseUrl/config/umbrales'),
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: json.encode({
        'umbral_critico': critico,
        'umbral_advertencia': advertencia,
      }),
    );
  }

  Future<void> updateContenedor(int id, String ubicacion, int capacidadMax) async {
    final token = await AuthService().getToken();
    await http.put(
      Uri.parse('$_baseUrl/contenedores/$id'),
      headers: {'Authorization': 'Bearer $token'},
      body: json.encode({
        'ubicacion': ubicacion,
        'capacidad_max': capacidadMax,
      }),
    );
  }

  Future<void> deleteContenedor(int id) async {
    final token = await AuthService().getToken();
    await http.delete(
      Uri.parse('$_baseUrl/contenedores/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }
  
}