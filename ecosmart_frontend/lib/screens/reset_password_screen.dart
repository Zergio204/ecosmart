import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/api_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  void _sendVerificationCode() async {
    try {
      await ApiService().sendVerificationCode(_emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Código enviado al correo')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _resetPassword() async {
    try {
      await ApiService().resetPassword(
        _emailController.text,
        _codeController.text,
        _newPasswordController.text,
      );
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recuperar Contraseña')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              '../assets/images/logo.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Correo electrónico'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sendVerificationCode,
              child: Text('Enviar Código'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(labelText: 'Código enviado al correo'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Nueva Contraseña'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _resetPassword,
              child: Text('Recuperar Contraseña'),
            ),
          ],
        ),
      ),
    );
  }
}