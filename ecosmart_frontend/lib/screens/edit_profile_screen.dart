// lib/screens/edit_profile_screen.dart
/*import 'package:flutter/material.dart';
import '../services/api_service.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ApiService _apiService = ApiService();

  // Controladores para los campos de entrada
  final TextEditingController nombreUsuarioController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Cargar los datos del usuario actual (ejemplo)
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final user = await _apiService.getUserData(); // Obtener datos del usuario
      setState(() {
        nombreUsuarioController.text = user.nombre;
        emailController.text = user.email;
        passwordController.text = ''; // No mostrar la contraseña actual
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar los datos del usuario')),
      );
    }
  }

  Future<void> _saveChanges() async {
    if (nombreUsuarioController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, complete todos los campos')),
      );
      return;
    }

    try {
      // Enviar los cambios al backend
      await _apiService.updateUserProfile(
        nombreUsuarioController.text,
        emailController.text,
        passwordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Información actualizada correctamente')),
      );

      // Redirigir a la pantalla anterior
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar la información')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://via.placeholder.com/150 '), // Imagen de perfil
            ),
            SizedBox(height: 16),

            // Campo de nombre de usuario
            TextField(
              controller: nombreUsuarioController,
              decoration: InputDecoration(labelText: 'Nombre de usuario'),
            ),
            SizedBox(height: 16),

            // Campo de e-mail
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Correo Electrónico'),
            ),
            SizedBox(height: 16),

            // Campo de contraseña
            TextField(
              controller: passwordController,
              obscureText: true, // Ocultar texto de la contraseña
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            SizedBox(height: 16),

            // Botón Guardar
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Guardar Información'),
            ),
          ],
        ),
      ),
    );
  }
}*/