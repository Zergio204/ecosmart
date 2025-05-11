// lib/screens/report_emergency_screen.dart
/*import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Para seleccionar imágenes
import 'dart:io';

class ReportEmergencyScreen extends StatefulWidget {
  @override
  _ReportEmergencyScreenState createState() => _ReportEmergencyScreenState();
}

class _ReportEmergencyScreenState extends State<ReportEmergencyScreen> {
  final TextEditingController subjectController = TextEditingController();
  XFile? selectedImage; // Almacena la imagen seleccionada

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = pickedFile;
      });
    }
  }

  void _submitReport() {
    if (subjectController.text.isEmpty || selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, complete todos los campos')),
      );
      return;
    }

    // Lógica para enviar el reporte al backend
    print('Asunto del reporte: ${subjectController.text}');
    print('Imagen seleccionada: ${selectedImage?.path}');

    // Redirige a la pantalla anterior después de guardar
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reportar una Emergencia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: subjectController,
              decoration: InputDecoration(labelText: 'Asunto del Reporte'),
            ),
            SizedBox(height: 16),

            // Sección para subir imagen
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Seleccionar Imagen'),
            ),
            SizedBox(height: 8),

            // Mostrar la imagen seleccionada
            if (selectedImage != null)
              Image.file(
                File(selectedImage!.path),
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              )
            else
              Text('No se ha seleccionado ninguna imagen'),

            SizedBox(height: 16),

            // Botones de acción
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _submitReport,
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
}*/