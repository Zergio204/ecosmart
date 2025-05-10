// lib/screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Cuenta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              '../assets/images/EcoSmart_logo.png', // Asegúrate de tener un logo adecuado
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),

            // Campos de entrada
            TextField(
              decoration: InputDecoration(
                labelText: 'Nombre de usuario',
              ),
            ),
            SizedBox(height: 16),

            TextField(
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
              ),
            ),
            SizedBox(height: 16),

            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            SizedBox(height: 24),

            // Selector de rol
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Rol'),
              items: <String>['Administrador', 'Operario', 'Ciudadano'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Lógica para manejar el cambio de rol
              },
            ),
            SizedBox(height: 24),

            // Botón de registro
            ElevatedButton(
              onPressed: () {
                // Lógica para enviar los datos al backend
                _registerUser(context);
              },
              child: Text('Crear Cuenta'),
            ),

            // Separador
            SizedBox(height: 24),

            // Opciones de inicio de sesión con proveedores externos
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Lógica para iniciar sesión con Google
                      _signInWithGoogle();
                    },
                    icon: Icon(Icons.g_mobiledata),
                    label: Text('Crear cuenta con Google'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Lógica para iniciar sesión con Microsoft Account
                      _signInWithMicrosoft();
                    },
                    icon: Icon(Icons.computer),
                    label: Text('Crear cuenta con Microsoft Account'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Lógica para iniciar sesión con Apple
                      _signInWithApple();
                    },
                    icon: Icon(Icons.apple),
                    label: Text('Crear cuenta con Apple'),
                  ),
                ),
              ],
            ),

            // Términos y Política de Privacidad
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // Navegar a los términos de uso
                    Navigator.pushNamed(context, '/terms-of-use');
                  },
                  child: Text('Terms of Use'),
                ),
                Text(' | '),
                TextButton(
                  onPressed: () {
                    // Navegar a la política de privacidad
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

  // Función para registrar usuario
  void _registerUser(BuildContext context) async {
    // Obtener valores de los campos de texto
    final username = ''; // Reemplazar con los valores del formulario
    final email = ''; // Reemplazar con los valores del formulario
    final password = ''; // Reemplazar con los valores del formulario

    try {
      // Llamada al backend para registrar el usuario
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/register'), // URL del endpoint de registro
        body: {
          'username': username,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        // Redirigir al login o dashboard después del registro exitoso
        Navigator.pushNamed(context, '/login');
      } else {
        // Mostrar mensaje de error
        print('Error al registrar usuario: ${response.body}');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
  }

  // Funciones para inicio de sesión con proveedores externos
  void _signInWithGoogle() {
    // Implementar lógica para Google Sign In
  }

  void _signInWithMicrosoft() {
    // Implementar lógica para Microsoft Account
  }

  void _signInWithApple() {
    // Implementar lógica para Apple Sign In
  }
}