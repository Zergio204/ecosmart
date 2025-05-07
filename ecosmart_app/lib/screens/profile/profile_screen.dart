import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecosmart_app/providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/user.png'),
            ),
            const SizedBox(height: 20),
            Text(
              authProvider.userRole ?? 'Invitado',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración de Cuenta'),
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
            if (authProvider.userRole == 'admin')
              ListTile(
                leading: const Icon(Icons.add_box),
                title: const Text('Añadir Contenedor'),
                onTap: () => Navigator.pushNamed(context, '/add-container'),
              ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Cerrar Sesión'),
              onTap: authProvider.logout,
            )
          ],
        ),
      ),
    );
  }
}