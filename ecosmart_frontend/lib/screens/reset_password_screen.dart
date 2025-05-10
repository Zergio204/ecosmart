// lib/screens/reset_password_screen.dart
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  void _sendVerificationCode() {
    // Lógica para enviar el código de verificación al correo electrónico
    print('Enviar código de verificación al correo: ${_emailController.text}');
  }

  void _resetPassword() {
    // Lógica para restablecer la contraseña
    print('Restablecer contraseña con código: ${_codeController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar Contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              '../assets/images/logo.png',
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),

            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
              ),
            ),
            SizedBox(height: 16),

            ElevatedButton(
              onPressed: _sendVerificationCode,
              child: Text('Enviar Código'),
            ),
            SizedBox(height: 16),

            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Código enviado al correo',
              ),
            ),
            SizedBox(height: 16),

            ElevatedButton(
              onPressed: _resetPassword,
              child: Text('Recuperar Contraseña'),
            ),

            // Términos y Política de Privacidad
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/terms-of-use');
                  },
                  child: Text('Terms of Use'),
                ),
                Text(' | '),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/privacy-policy');
                  },
                  child: Text('Privacy Policy'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}