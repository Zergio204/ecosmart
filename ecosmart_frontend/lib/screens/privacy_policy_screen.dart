// lib/screens/privacy_policy_screen.dart
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Política de Privacidad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Política de Privacidad',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              '''
              Esta es la política de privacidad de la aplicación EcoSmart. 

              1. **Recopilación de Datos**: Recopilamos datos como nombre de usuario, correo electrónico y contraseña.
              2. **Uso de Datos**: Utilizamos estos datos para mejorar la experiencia del usuario.
              3. **Seguridad**: Implementamos medidas de seguridad para proteger tus datos.
              4. **Comunicaciones**: Podemos enviarte notificaciones relacionadas con tu cuenta.
              5. **Cambios en la Política**: Nos reservamos el derecho a modificar esta política sin previo aviso.
              ''',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}