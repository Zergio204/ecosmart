import 'package:ecosmart_frontend/screens/alertas_screen.dart';
import 'package:ecosmart_frontend/screens/dashboard_screen.dart';
import 'package:ecosmart_frontend/screens/emergencias_screen.dart';
import 'package:ecosmart_frontend/screens/rutas_screen.dart';
import 'package:ecosmart_frontend/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';
import 'screens/contenedor_detail_screen.dart';
import 'screens/register_screen.dart';
import 'screens/terms_of_use_screen.dart';
import 'screens/privacy_policy_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService();
  await authService.loadToken(); // ¡Cargar token al iniciar!
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authService),
      ],
      child: EcoSmartApp(),
    ),
  );
}

class EcoSmartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoSmart',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: LoginScreen(),
      routes: {
        '/dashboard': (context) => DashboardScreen(),
        '/contenedor-detail': (context) => ContenedorDetailScreen(
              contenedorId: ModalRoute.of(context)!.settings.arguments as int,
            ),
        '/alertas': (context) => AlertasScreen(),
        '/rutas': (context) => RutasScreen(),
        '/emergencias': (context) => EmergenciasScreen(),
        '/settings': (context) => SettingsScreen(),
        '/register': (context) => RegisterScreen(),
        '/terms-of-use': (context) => TermsOfUseScreen(), // Nueva ruta
        '/privacy-policy': (context) => PrivacyPolicyScreen(), // Nueva ruta
      },
    );
  }
}