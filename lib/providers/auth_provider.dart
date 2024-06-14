import 'package:flutter/material.dart';
import 'package:uniattendmovil/services/auth/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isAuthenticated = false;
  bool _isAdmin = false;

  bool get isAuthenticated => _isAuthenticated;
  bool get isAdmin => _isAdmin;

  Future<void> login(String email, String password) async {
    final result = await _authService.login(email, password);
    if (result['success']) {
      _isAuthenticated = true;
      _isAdmin = await _authService.isAdmin();
      notifyListeners();
    } else {
      throw Exception(result['message']);
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _isAuthenticated = false;
    _isAdmin = false;
    notifyListeners();
  }

  Future<void> checkAuthenticationStatus() async {
    _isAuthenticated = await _authService.isAuthenticated();
    _isAdmin = await _authService.isAdmin();
    notifyListeners();
  }
}