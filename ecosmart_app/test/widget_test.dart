// widget_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:ecosmart_app/screens/auth/login_screen.dart'; // Importa la pantalla de login

void main() {
  group('LoginScreen Widget Tests', () {
    testWidgets('Verificar elementos de la pantalla de login', (WidgetTester tester) async {
      // Construir la pantalla de login
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Verificar que existen los campos de email y contraseña
      expect(find.byType(TextFormField), findsNWidgets(2)); // Email y contraseña
      expect(find.text('Iniciar Sesión'), findsOneWidget); // Título
      expect(find.byType(ElevatedButton), findsOneWidget); // Botón de login
      expect(find.text('Crear cuenta'), findsOneWidget); // Enlace a registro
    });

    testWidgets('Simular inicio de sesión fallido', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Introducir credenciales inválidas
      await tester.enterText(find.byType(TextFormField).at(0), 'invalid_email');
      await tester.enterText(find.byType(TextFormField).at(1), 'short');
      await tester.tap(find.text('Ingresar'));
      await tester.pump();

      // Verificar mensaje de error
      expect(find.text('Campo requerido'), findsNothing); // Validación de email
      expect(find.text('Mínimo 6 caracteres'), findsOneWidget); // Validación de contraseña
    });
  });
}