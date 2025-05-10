import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('Dashboard'),
            onTap: () => Navigator.pushNamed(context, '/dashboard'),
          ),
          ListTile(
            title: Text('Rutas'),
            onTap: () => Navigator.pushNamed(context, '/rutas'),
          ),
          ListTile(
            title: Text('Emergencias'),
            onTap: () => Navigator.pushNamed(context, '/emergencias'),
          ),
          ListTile(
            title: Text('Cerrar Sesión'),
            onTap: () async {
              await AuthService().logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}