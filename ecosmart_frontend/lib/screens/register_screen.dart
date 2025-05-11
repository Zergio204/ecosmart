// lib/screens/register_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedRol = 'ciudadano'; // Rol por defecto

  void _registerUser() async {
    try {
      // Obtener valores de los campos
      final nombre = _nombreController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      final rol = _selectedRol;

      // Llamar al servicio de registro
      await ApiService().register(nombre, email, password, rol);

      // Redirigir al login
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
      appBar: AppBar(title: Text('Crear Cuenta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              '../assets/images/logo.png', // Asegúrate de que esta imagen exista
              width: 150,
              height: 150,
            ),
            SizedBox(height: 30),
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre de usuario'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _registerUser,
              child: Text('Crear Cuenta'),
            ),
            SizedBox(height: 16),
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