// lib/screens/create_container_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/contenedor.dart';

class CreateContainerScreen extends StatefulWidget {
  @override
  _CreateContainerScreenState createState() => _CreateContainerScreenState();
}

class _CreateContainerScreenState extends State<CreateContainerScreen> {
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _capacidadMaxController = TextEditingController();
  bool _estadoInicial = true;

  void _createContainer() async {
    try {
      final direccion = _direccionController.text;
      final capacidadMax = int.parse(_capacidadMaxController.text);

      // Crear el objeto Contenedor
      final contenedor = Contenedor(
        id: 0, // ID se asigna automáticamente en el backend
        ubicacion: direccion,
        capacidadMax: capacidadMax,
        nivelLlenado: 0,
        umbralCritico: 80, // Valor predeterminado
        lat: null, // Opcional: Obtener coordenadas con geolocator
        lng: null,
        estado: _estadoInicial ? 'Recogido' : 'Pendiente',
      );

      // Llamar al servicio
      await ApiService().createContenedor(contenedor);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Contenedor creado exitosamente')),
      );
      Navigator.pop(context); // Volver a la pantalla anterior
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Contenedor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _direccionController,
              decoration: InputDecoration(labelText: 'Dirección'),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _capacidadMaxController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Capacidad Max'),
                  ),
                ),
                SizedBox(width: 8),
                Text('litros'),
              ],
            ),
            SizedBox(height: 16),
            SwitchListTile(
              title: Text('Estado inicial'),
              value: _estadoInicial,
              onChanged: (value) {
                setState(() => _estadoInicial = value);
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _createContainer,
              child: Text('Guardar'),
            ),
            SizedBox(width: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}