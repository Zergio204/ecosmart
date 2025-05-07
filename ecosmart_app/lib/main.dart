import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecosmart_app/services/notification_service.dart';
import 'providers/auth_provider.dart';
import 'providers/container_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'package:dotenv/dotenv.dart' show load, env;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await load();
  await NotificationService.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ContainerProvider()),
      ],
      child: EcoSmartApp(),
    ),
  );
}

class EcoSmartApp extends StatelessWidget {
  const EcoSmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoSmart',
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Provider.of<AuthProvider>(context).isDarkMode
            ? Brightness.dark
            : Brightness.light,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/profile': (context) => ProfileScreen(),
        // Añadir todas las rutas aquí
      },
    );
  }
}