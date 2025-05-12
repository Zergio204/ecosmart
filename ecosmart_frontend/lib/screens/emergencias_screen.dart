import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';

class EmergenciasScreen extends StatefulWidget {
  @override
  _EmergenciasScreenState createState() => _EmergenciasScreenState();
}

class _EmergenciasScreenState extends State<EmergenciasScreen> {
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
        // Subir la imagen al servidor (ejemplo: Firebase Storage)
        final imageUrl = await _uploadImage(_imagen!);

        // Llamar al servicio con los tres parámetros
        await ApiService().reportarEmergencia(
          1, // ID del contenedor seleccionado
          _descripcionController.text,
          imageUrl,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Emergencia reportada exitosamente')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al reportar emergencia: $e')),
        );
      }
    }
  }

  // Método simulado para subir la imagen (reemplazar con tu lógica real)
  Future<String> _uploadImage(XFile image) async {
    // Aquí debes implementar la subida a un servicio como Firebase Storage o AWS S3
    return 'https://example.com/images/ ${image.name}';
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
                decoration: InputDecoration(labelText: 'Asunto del Reporte'),
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