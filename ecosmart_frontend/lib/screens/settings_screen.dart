// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool globalNotificationsEnabled = true;
  bool criticalAlertsEnabled = true;
  bool moderateAlertsEnabled = true;
  bool predictionNotificationsEnabled = true;

  double criticalThreshold = 80.0;
  double moderateThreshold = 50.0;

  String themeMode = 'Claro';
  String distanceUnit = 'Km';
  bool showGraphs = true;

  // Verificar si el usuario es administrador
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    // Cargar preferencias del usuario desde el backend
    // Ejemplo:
    // ApiService().getUserPreferences().then((prefs) {
    //   setState(() {
    //     globalNotificationsEnabled = prefs.globalNotifications;
    //     // ... otros campos ...
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuración')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Notificaciones Globales
          SwitchListTile(
            title: Text('Notificaciones Globales'),
            value: globalNotificationsEnabled,
            onChanged: (value) {
              setState(() {
                globalNotificationsEnabled = value;
              });
              // Guardar en backend
              // ApiService().updateUserPreferences(...);
            },
          ),

          // Alertas Críticas
          SwitchListTile(
            title: Text('Alertas Críticas'),
            value: criticalAlertsEnabled,
            onChanged: (value) {
              setState(() {
                criticalAlertsEnabled = value;
              });
              // Guardar en backend
            },
          ),

          // Alertas Moderadas
          SwitchListTile(
            title: Text('Alertas Moderadas'),
            value: moderateAlertsEnabled,
            onChanged: (value) {
              setState(() {
                moderateAlertsEnabled = value;
              });
              // Guardar en backend
            },
          ),

          // Notificaciones de Predicciones
          SwitchListTile(
            title: Text('Notificaciones de Predicciones'),
            value: predictionNotificationsEnabled,
            onChanged: (value) {
              setState(() {
                predictionNotificationsEnabled = value;
              });
              // Guardar en backend
            },
          ),

          Divider(),

          // Ajuste de Umbrales
          Text('Ajuste de umbrales de alerta', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),

          // Slider Alertas Críticas
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Alertas Críticas'),
                  Text('${criticalThreshold.round()} %'),
                ],
              ),
              Slider(
                value: criticalThreshold,
                min: 0,
                max: 100,
                divisions: 100,
                label: '${criticalThreshold.round()}%',
                onChanged: (value) {
                  setState(() {
                    criticalThreshold = value;
                  });
                  // Guardar en backend
                },
              ),
            ],
          ),

          // Slider Alertas Moderadas
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Alertas Moderadas'),
                  Text('${moderateThreshold.round()} %'),
                ],
              ),
              Slider(
                value: moderateThreshold,
                min: 0,
                max: 100,
                divisions: 100,
                label: '${moderateThreshold.round()}%',
                onChanged: (value) {
                  setState(() {
                    moderateThreshold = value;
                  });
                  // Guardar en backend
                },
              ),
            ],
          ),

          Divider(),

          // Preferencias de Datos
          Text('Preferencias de datos', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),

          // Tema de la App
          ListTile(
            title: Text('Color de la App'),
            trailing: ToggleButtons(
              children: [Text('Oscuro'), Text('Claro')],
              isSelected: [themeMode == 'Oscuro', themeMode == 'Claro'],
              onPressed: (index) {
                setState(() {
                  themeMode = index == 0 ? 'Oscuro' : 'Claro';
                });
                // Guardar en backend
              },
            ),
          ),

          // Unidad de Distancia
          ListTile(
            title: Text('Unidad de distancia'),
            trailing: ToggleButtons(
              children: [Text('Km'), Text('Miles')],
              isSelected: [distanceUnit == 'Km', distanceUnit == 'Miles'],
              onPressed: (index) {
                setState(() {
                  distanceUnit = index == 0 ? 'Km' : 'Miles';
                });
                // Guardar en backend
              },
            ),
          ),

          // Mostrar/Ocultar Gráficos
          ListTile(
            title: Text('Gráficos en el dashboard'),
            trailing: ToggleButtons(
              children: [Text('Mostrar'), Text('Ocultar')],
              isSelected: [showGraphs, !showGraphs],
              onPressed: (index) {
                setState(() {
                  showGraphs = index == 0;
                });
                // Guardar en backend
              },
            ),
          ),

          Divider(),

          // Configuración de Cuenta
          Text('Configuración de cuenta', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),

          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/edit-profile');
            },
            child: Text('Editar Perfil'),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              final authService = Provider.of<AuthService>(context, listen: false);
              await authService.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text('Cerrar Sesión'),
          ),

          Divider(),

          // Opciones Avanzadas (Solo para Admin)
          if (isAdmin) ...[
            Text('Opciones avanzadas', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add-container');
              },
              child: Text('Añadir Nuevo Contenedor'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                try {
                  final data = await ApiService().exportarDatos();
                  // Descargar archivo CSV/Excel
                  // Ejemplo:
                  // final bytes = utf8.encode(data);
                  // await FileSaver.instance.saveFile('datos.csv', bytes, 'text/csv');
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              },
              child: Text('Exportar Datos'),
            ),
          ],
        ],
      ),
    );
  }
}