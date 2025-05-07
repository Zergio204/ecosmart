import 'package:flutter/material.dart';
import 'package:ecosmart_app/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userRole;
  bool _isDarkMode = false; 

  bool get isLoggedIn => _isLoggedIn;
  String? get userRole => _userRole;
  bool get isDarkMode => _isDarkMode;

  Future<void> checkAuthStatus() async {
    final token = await AuthService.getToken();
    final role = await AuthService.getUserRole();
    if (token != null && role != null) {
      _isLoggedIn = true;
      _userRole = role;
      notifyListeners();
    }
  }

  void toggleDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _userRole = null;
    notifyListeners();
  }
}