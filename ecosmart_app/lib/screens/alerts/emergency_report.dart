import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecosmart_app/services/alert_service.dart';
import 'dart:io';

class EmergencyReportScreen extends StatefulWidget {
  final int containerId;

  const EmergencyReportScreen({super.key, required this.containerId});

  @override
  _EmergencyReportScreenState createState() => _EmergencyReportScreenState();
}

class _EmergencyReportScreenState extends State<EmergencyReportScreen> {
  final _descriptionController = TextEditingController();
  XFile? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() => _image = pickedFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reportar Emergencia')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Tomar Foto'),
            ),
            if (_image != null) Image.file(File(_image!.path), height: 200),
            ElevatedButton(
              onPressed: () async {
                await AlertService.reportEmergency(
                  widget.containerId,
                  _descriptionController.text,
                  _image?.path
                );
                Navigator.pop(context);
              },
              child: const Text('Enviar Reporte'),
            )
          ],
        ),
      ),
    );
  }
}