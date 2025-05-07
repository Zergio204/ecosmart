import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  String _distanceUnit = 'km';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs.getBool('darkMode') ?? false;
      _distanceUnit = prefs.getString('distanceUnit') ?? 'km';
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _darkMode);
    await prefs.setString('distanceUnit', _distanceUnit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Modo Oscuro'),
              value: _darkMode,
              onChanged: (value) {
                setState(() => _darkMode = value);
                _savePreferences();
              },
            ),
            DropdownButtonFormField<String>(
              value: _distanceUnit,
              decoration: const InputDecoration(labelText: 'Unidad de Distancia'),
              items: ['km', 'millas'].map((unit) {
                return DropdownMenuItem(value: unit, child: Text(unit));
              }).toList(),
              onChanged: (value) {
                setState(() => _distanceUnit = value!);
                _savePreferences();
              },
            )
          ],
        ),
      ),
    );
  }
}