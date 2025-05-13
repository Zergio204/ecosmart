// lib/screens/rutas_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/ruta.dart';

class RutasScreen extends StatefulWidget {
  @override
  _RutasScreenState createState() => _RutasScreenState();
}

class _RutasScreenState extends State<RutasScreen> {
  List<Ruta> rutas = [];
  bool _isLoading = false;

  void _fetchRutas() async {
    setState(() => _isLoading = true);

    try {
      final data = await ApiService().getRutas();
      setState(() {
        rutas = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar las rutas')),
      );
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: rutas.length,
                    itemBuilder: (context, index) {
                      final ruta = rutas[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text('R${ruta.id}'),
                          ),
                          title: Text('Ruta ${ruta.id}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${ruta.fecha} - ${ruta.duracionMin} minutos'),
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
                                    arguments: ruta.id, // ¡Pasar el ID como argumento!
                                  );
                                },
                                child: Text('Ver Detalles'),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () async {
                                  try {
                                    await ApiService().eliminarRuta(ruta.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Ruta eliminada')),
                                    );
                                    setState(() {
                                      rutas.remove(ruta); // Actualizar la lista
                                    });
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Error: $e')),
                                    );
                                  }
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
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/create-route'),
                  child: Text('Crear Nueva Ruta'),
                ),
              ],
            ),
    );
  }
}