// lib/screens/terms_of_use_screen.dart
import 'package:flutter/material.dart';

class TermsOfUseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Términos de Uso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Términos de Uso',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              '''
              Estos son los términos de uso de la aplicación EcoSmart. Por favor, lea atentamente antes de continuar.

              1. **Uso del Servicio**: Este servicio está destinado a usuarios registrados que acepten estos términos.
              2. **Privacidad**: Respetamos su privacidad. Consulte nuestra Política de Privacidad para más detalles.
              3. **Responsabilidad**: Los usuarios son responsables de sus acciones dentro de la aplicación.
              4. **Cambio de Términos**: Nos reservamos el derecho a modificar estos términos sin previo aviso.
              ''',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}