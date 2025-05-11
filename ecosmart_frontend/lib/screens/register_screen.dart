// lib/screens/register_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../screens/login_screen.dart';

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
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Correo electrónico'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Rol'),
              value: _selectedRol,
              items: ['admin', 'operario', 'ciudadano']
                  .map((rol) => DropdownMenuItem(value: rol, child: Text(rol)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRol = value ?? 'ciudadano';
                });
              },
            ),
            ElevatedButton(
              onPressed: _registerUser,
              child: Text('Crear Cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}