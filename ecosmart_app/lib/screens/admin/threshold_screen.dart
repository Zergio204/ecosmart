import 'package:flutter/material.dart';
import 'package:ecosmart_app/services/container_service.dart';

class ThresholdScreen extends StatefulWidget {
  const ThresholdScreen({super.key});

  @override
  _ThresholdScreenState createState() => _ThresholdScreenState();
}

class _ThresholdScreenState extends State<ThresholdScreen> {
  final _formKey = GlobalKey<FormState>();
  double _criticalThreshold = 80;
  double _warningThreshold = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurar Umbrales')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Slider(
                value: _criticalThreshold,
                min: 50,
                max: 100,
                divisions: 5,
                label: 'Crítico: $_criticalThreshold%',
                onChanged: (value) => setState(() => _criticalThreshold = value),
              ),
              Slider(
                value: _warningThreshold,
                min: 30,
                max: 80,
                divisions: 5,
                label: 'Advertencia: $_warningThreshold%',
                onChanged: (value) => setState(() => _warningThreshold = value),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await ContainerService.updateThresholds(
                      _criticalThreshold.toInt(),
                      _warningThreshold.toInt()
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Umbrales actualizados'))
                    );
                  }
                },
                child: const Text('Guardar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}