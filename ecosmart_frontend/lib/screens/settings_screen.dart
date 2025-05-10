import 'package:flutter/material.dart';
import '../services/api_service.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuración')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            FutureBuilder<Map<String, dynamic>>(
              future: ApiService().getConfigUmbrales(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text('Umbral Crítico'),
                      Slider(
                        value: snapshot.data!['umbral_critico'].toDouble(),
                        min: 50,
                        max: 100,
                        divisions: 50,
                        label: '${snapshot.data!['umbral_critico']}%',
                        onChanged: (value) async {
                          await ApiService().updateConfigUmbrales(
                            value.toInt(),
                            snapshot.data!['umbral_advertencia'],
                          );
                        },
                      ),
                      // Slider para umbral_advertencia
                    ],
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}