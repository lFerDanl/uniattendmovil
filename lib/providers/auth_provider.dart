import 'package:flutter/material.dart';
import 'package:uniattendmovil/models/user_model.dart';
import 'package:uniattendmovil/services/auth/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  Future<void> login(String email, String password) async {
    try {
      final token = await _authService.login(email, password);
      if (token != null) {
        final user = await _authService.getYourProfile(token);
        if (user != null) {
          _user = user;
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }

  Future<void> loadProfile() async {
    try {
      _user = await _authService.getProfile();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load profile');
    }
  }

  Future<void> refreshToken() async {
    try {
      await _authService.refreshToken();
    } catch (e) {
      throw Exception('Failed to refresh token');
    }
  }

  Future<bool> isAuthenticated() async {
    return await _authService.isAuthenticated();
  }

  Future<bool> isAdmin() async {
    return await _authService.isAdmin();
  }

  Future<bool> isUser() async {
    return await _authService.isUser();
  }
}