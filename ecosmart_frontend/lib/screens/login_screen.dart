// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _isLoading = false; // Para manejar el estado de carga

  void _login(BuildContext context) async {
    if (_isLoading) return; // Evitar múltiples clics

    setState(() => _isLoading = true);

    try {
      final usuario = await _apiService.login(
        emailController.text,
        passwordController.text,
      );
      await Provider.of<AuthService>(context, listen: false).saveToken(usuario.id.toString());
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Contraseña')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(context),
              child: _isLoading ? CircularProgressIndicator() : Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}