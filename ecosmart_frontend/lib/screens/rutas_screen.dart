/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/api_service.dart';
import '../models/ruta.dart';

class RutasScreen extends StatefulWidget {
  @override
  _RutasScreenState createState() => _RutasScreenState();
}

class _RutasScreenState extends State<RutasScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Ruta> rutas = [];
  bool _isLoading = false;

  void _fetchRutas() async {
    setState(() => _isLoading = true);

    try {
      final response = await http.get(
        Uri.parse('http://localhost:3000/api/rutas'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          rutas = Ruta.fromList(data);
          _isLoading = false;
        });
      } else {
        throw Exception('Error al cargar las rutas');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchRutas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rutas Programadas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Barra de búsqueda y filtros
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    // Lógica para aplicar filtros
                  },
                ),
              ],
            ),
            SizedBox(height: 16),

            // Lista de rutas
            Expanded(
              child: ListView.builder(
                itemCount: rutas.length,
                itemBuilder: (context, index) {
                  final ruta = rutas[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: CircleAvatar(child: Text('R${ruta.id}')),
                      title: Text('Ruta ${ruta.id}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${ruta.fecha} ${ruta.duracionMin}'),
                          Text('${ruta.contenedores.length} Contenedores'),
                          Text('${ruta.distanciaKm} km'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/ruta-detail',
                                arguments: ruta.id,
                              );
                            },
                            child: Text('Ver Detalles'),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              // Lógica para eliminar ruta
                            },
                            child: Text('Eliminar Ruta'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Botón para crear nueva ruta
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/crear-ruta'),
              child: Text('Crear Nueva Ruta'),
            ),
          ],
        ),
      ),
    );
  }
}*/