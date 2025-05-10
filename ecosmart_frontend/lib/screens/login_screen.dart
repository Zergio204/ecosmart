import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
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
            
            // Campo de correo electrónico
            TextField(
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
              ),
            ),
            SizedBox(height: 16),

            // Campo de contraseña
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            SizedBox(height: 24),

            // Botón de inicio de sesión
            ElevatedButton(
              onPressed: () {
                // Lógica para iniciar sesión
              },
              child: Text('Iniciar Sesión'),
            ),
            SizedBox(height: 16),

            // Enlace para recuperar contraseña
            TextButton(
              onPressed: () {
                // Navegar a la pantalla de recuperación de contraseña
                Navigator.pushNamed(context, '/reset-password');
              },
              child: Text('¿No recuerda su contraseña?'),
            ),

            // Botón para ir a la pantalla de registro
            TextButton(
              onPressed: () {
                // Navegar a la pantalla de registro
                Navigator.pushNamed(context, '/register');
              },
              child: Text('¿No tienes una cuenta? Crear cuenta'),
            ),

            // Opciones de inicio de sesión con proveedores externos
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Lógica para iniciar sesión con Google
                    },
                    icon: Icon(Icons.g_mobiledata),
                    label: Text('Iniciar sesión con Google'),
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
                    },
                    icon: Icon(Icons.computer), // Usar ícono genérico o FontAwesome
                    label: Text('Iniciar sesión con Microsoft Account'),
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
                    },
                    icon: Icon(Icons.apple),
                    label: Text('Iniciar sesión con Apple'),
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
}