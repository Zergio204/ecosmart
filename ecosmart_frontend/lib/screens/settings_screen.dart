// lib/screens/settings_screen.dart
/*import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  // Estado inicial de las preferencias
  bool globalNotificationsEnabled = true;
  bool criticalAlertsEnabled = true;
  bool moderateAlertsEnabled = true;
  bool predictionNotificationsEnabled = true;

  double criticalThreshold = 80.0; // Umbral de alertas críticas
  double moderateThreshold = 50.0; // Umbral de alertas moderadas

  String themeMode = 'Claro'; // Tema de la app
  String distanceUnit = 'Km'; // Unidad de distancia
  bool showGraphs = true; // Gráficos en el dashboard

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
      ),
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
            },
          ),

          // Ajuste de Umbrales de Alerta
          Text('Ajuste de umbrales de alerta'),
          SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Alertas Críticas'),
              Text('${criticalThreshold.toStringAsFixed(0)} %'),
            ],
          ),
          Slider(
            value: criticalThreshold,
            min: 0,
            max: 100,
            onChanged: (value) {
              setState(() {
                criticalThreshold = value;
              });
            },
          ),
          SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Alertas Moderadas'),
              Text('${moderateThreshold.toStringAsFixed(0)} %'),
            ],
          ),
          Slider(
            value: moderateThreshold,
            min: 0,
            max: 100,
            onChanged: (value) {
              setState(() {
                moderateThreshold = value;
              });
            },
          ),

          // Preferencias de Datos
          Text('Preferencias de datos'),
          SizedBox(height: 16),

          Row(
            children: [
              Text('Color de la App:'),
              RadioListTile<String>(
                title: Text('Oscuro'),
                value: 'Oscuro',
                groupValue: themeMode,
                onChanged: (value) {
                  setState(() {
                    themeMode = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('Claro'),
                value: 'Claro',
                groupValue: themeMode,
                onChanged: (value) {
                  setState(() {
                    themeMode = value!;
                  });
                },
              ),
            ],
          ),

          Row(
            children: [
              Text('Unidad de distancia:'),
              RadioListTile<String>(
                title: Text('Km'),
                value: 'Km',
                groupValue: distanceUnit,
                onChanged: (value) {
                  setState(() {
                    distanceUnit = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('Miles'),
                value: 'Miles',
                groupValue: distanceUnit,
                onChanged: (value) {
                  setState(() {
                    distanceUnit = value!;
                  });
                },
              ),
            ],
          ),

          Row(
            children: [
              Text('Gráficos en el dashboard:'),
              RadioListTile<bool>(
                title: Text('Mostrar'),
                value: true,
                groupValue: showGraphs,
                onChanged: (value) {
                  setState(() {
                    showGraphs = value!;
                  });
                },
              ),
              RadioListTile<bool>(
                title: Text('Ocultar'),
                value: false,
                groupValue: showGraphs,
                onChanged: (value) {
                  setState(() {
                    showGraphs = value!;
                  });
                },
              ),
            ],
          ),

          // Configuración de Cuenta
          Text('Configuración de cuenta'),
          SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              // Lógica para editar perfil
            },
            child: Text('Editar Perfil'),
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica para cerrar sesión
            },
            child: Text('Cerrar Sesión'),
          ),

          // Opciones Avanzadas
          Text('Opciones avanzadas'),
          SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              // Redirige a la pantalla de añadir contenedor
            },
            child: Text('Añadir Nuevo Contenedor'),
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica para exportar datos
            },
            child: Text('Exportar Datos'),
          ),
        ],
      ),
    );
  }
}*/