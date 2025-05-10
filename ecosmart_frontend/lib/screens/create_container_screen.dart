// lib/screens/create_container_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/contenedor.dart';

class CreateContainerScreen extends StatefulWidget {
  @override
  _CreateContainerScreenState createState() => _CreateContainerScreenState();
}

class _CreateContainerScreenState extends State<CreateContainerScreen> {
  final ApiService _apiService = ApiService();

  // Controladores para los campos de entrada
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController capacidadMaxController = TextEditingController();
  bool estadoInicial = true;

  @override
  void dispose() {
    direccionController.dispose();
    capacidadMaxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Contenedor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: direccionController,
              decoration: InputDecoration(labelText: 'Dirección'),
            ),
            SizedBox(height: 16),

            // Campo de Capacidad Máxima
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: capacidadMaxController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Capacidad Max'),
                  ),
                ),
                SizedBox(width: 8),
                Text('litros'),
              ],
            ),
            SizedBox(height: 16),

            // Interruptor para Estado Inicial
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Estado inicial'),
                Switch(
                  value: estadoInicial,
                  onChanged: (value) {
                    setState(() {
                      estadoInicial = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),

            // Botones de acción
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Validar y guardar el contenedor
                    if (direccionController.text.isEmpty ||
                        capacidadMaxController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Por favor, complete todos los campos')),
                      );
                      return;
                    }

                    try {
                      final nuevaCapacidad = int.parse(capacidadMaxController.text);
                      final contenedor = Contenedor(
                        id: 0, // ID se asignará automáticamente en el backend
                        ubicacion: direccionController.text,
                        capacidadMax: nuevaCapacidad,
                        nivelLlenado: 0,
                        umbralCritico: 80, // Valor predeterminado
                        lat: null, // Coordenadas se pueden agregar posteriormente
                        lng: null,
                        estado: estadoInicial ? 'Recogido' : 'Pendiente',
                      );

                      await _apiService.createContenedor(contenedor);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Contenedor creado exitosamente')),
                      );

                      // Redirigir a la pantalla anterior
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error al crear el contenedor: $e')),
                      );
                    }
                  },
                  child: Text('Guardar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Volver a la pantalla anterior
                  },
                  child: Text('Volver'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}