// lib/screens/emergencias_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/emergencia.dart';

class EmergenciasScreen extends StatefulWidget {
  @override
  _EmergenciasScreenState createState() => _EmergenciasScreenState();
}

class _EmergenciasScreenState extends State<EmergenciasScreen> {
  List<Emergencia> emergencias = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchEmergencias();
  }

  Future<void> _fetchEmergencias() async {
    setState(() => _isLoading = true);

    try {
      final data = await ApiService().getEmergencias();
      setState(() {
        emergencias = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar emergencias')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Emergencias Reportadas')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: emergencias.length,
              itemBuilder: (context, index) {
                final emergencia = emergencias[index];
                return ListTile(
                  title: Text(emergencia.descripcion),
                  subtitle: Text('Contenedor ${emergencia.idContenedor}'),
                  leading: Image.network(emergencia.imagenUrl),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/report-emergency'),
        child: Icon(Icons.add),
      ),
    );
  }
}