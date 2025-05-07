import 'package:dotenv/dotenv.dart' show env;

class Environment {
  static String get backendUrl {
    return env['BACKEND_URL'] ?? 'http://localhost:3000/api';
  }

  static String get mapboxToken {
    return env['MAPBOX_TOKEN'] ?? 'YOUR_DEFAULT_TOKEN';
  }

  static bool get isProduction {
    return env['ENV'] == 'production';
  }
}