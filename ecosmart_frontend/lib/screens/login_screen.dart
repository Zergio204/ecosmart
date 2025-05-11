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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              '../assets/images/logo.png',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 30),

            // Campo de usuario/e-mail
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
            SizedBox(height: 16),

            // Campo de contraseña
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            SizedBox(height: 24),

            // Botón de inicio de sesión
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Log In'),
            ),
            SizedBox(height: 16),

            // Enlace para crear cuenta
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/register'),
              child: Text('No tienes una cuenta? Crear cuenta'),
            ),
            SizedBox(height: 8),

            // Enlace para recuperar contraseña
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/reset-password'),
              child: Text('No recuerda su contraseña?'),
            ),
            SizedBox(height: 16),

            // Términos y Política de Privacidad
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/terms-of-use'),
                  child: Text('Terms of Use'),
                ),
                Text('|'),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/privacy-policy'),
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