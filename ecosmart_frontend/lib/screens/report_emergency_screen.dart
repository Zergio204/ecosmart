// lib/screens/report_emergency_screen.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../services/api_service.dart';

class ReportEmergencyScreen extends StatefulWidget {
  @override
  _ReportEmergencyScreenState createState() => _ReportEmergencyScreenState();
}

class _ReportEmergencyScreenState extends State<ReportEmergencyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descripcionController = TextEditingController();
  XFile? _imagen;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    _imagen = await picker.pickImage(source: ImageSource.camera);
  }

  Future<void> _reportarEmergencia() async {
    if (_formKey.currentState!.validate() && _imagen != null) {
      try {
        // Subir imagen al servidor
        final request = http.MultipartRequest(
          'POST',
          Uri.parse('http://localhost:3000/api/emergencias'),
        );

        // Adjuntar imagen
        request.files.add(
          await http.MultipartFile.fromPath(
            'imagen',
            _imagen!.path,
          ),
        );

        // Adjuntar otros campos
        request.fields['id_contenedor'] = '1'; // ID del contenedor seleccionado
        request.fields['descripcion'] = _descripcionController.text;

        // Enviar solicitud
        final response = await request.send();
        if (response.statusCode == 201) {
          Navigator.pop(context);
        } else {
          throw Exception('Error al reportar emergencia');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reportar Emergencia')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Tomar Foto'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _reportarEmergencia,
                child: Text('Enviar Reporte'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}