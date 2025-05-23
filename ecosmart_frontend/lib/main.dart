import 'package:ecosmart_frontend/models/contenedor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecosmart_frontend/services/auth_service.dart';
import 'package:ecosmart_frontend/screens/login_screen.dart';
import 'package:ecosmart_frontend/screens/register_screen.dart';
import 'package:ecosmart_frontend/screens/terms_of_use_screen.dart';
import 'package:ecosmart_frontend/screens/privacy_policy_screen.dart';
import 'package:ecosmart_frontend/screens/reset_password_screen.dart';
import 'package:ecosmart_frontend/screens/create_container_screen.dart';
import 'package:ecosmart_frontend/screens/container_detail_screen.dart';
import 'package:ecosmart_frontend/screens/dashboard_screen.dart';
import 'package:ecosmart_frontend/screens/edit_profile_screen.dart';
import 'package:ecosmart_frontend/screens/emergencias_screen.dart';
import 'package:ecosmart_frontend/screens/report_emergency_screen.dart';
import 'package:ecosmart_frontend/screens/ruta_detail_screen.dart';
import 'package:ecosmart_frontend/screens/rutas_screen.dart';
import 'package:ecosmart_frontend/screens/create_route_screen.dart';
import 'package:ecosmart_frontend/screens/route_planning_screen.dart';
import 'package:ecosmart_frontend/screens/settings_screen.dart';

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
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/terms-of-use': (context) => TermsOfUseScreen(),
        '/privacy-policy': (context) => PrivacyPolicyScreen(),
        '/reset-password': (context) => ResetPasswordScreen(),
        '/create-container': (context) => CreateContainerScreen(),
        '/container-detail': (context) => ContainerDetailScreen(
          contenedorId: ModalRoute.of(context)?.settings.arguments as int,
        ),
        '/dashboard': (context) => DashboardScreen(),
        '/edit-profile': (context) => EditProfileScreen(),
        '/emergencias': (context) => EmergenciasScreen(),
        '/report-emergency': (context) => ReportEmergencyScreen(),
        '/rutas': (context) => RutasScreen(),
        '/create-route': (context) => CreateRouteScreen(),
        '/ruta-detail': (context) => RutaDetailScreen(
          rutaId: ModalRoute.of(context)?.settings.arguments as int,
        ),
        '/route-planning': (context) => RoutePlanningScreen(
          contenedores: ModalRoute.of(context)?.settings.arguments as List<Contenedor>,
        ),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}