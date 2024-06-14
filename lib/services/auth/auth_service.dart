import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "http://10.0.2.2:8080";
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      await storage.write(key: 'token', value: data['token']);
      await storage.write(key: 'role', value: data['role']);
      return {'success': true, 'data': data};
    } else {
      return {'success': false, 'message': response.body};
    }
  }

  Future<void> logout() async {
    await storage.deleteAll();
  }

  Future<bool> isAuthenticated() async {
    String? token = await storage.read(key: 'token');
    return token != null;
  }

  Future<bool> isAdmin() async {
    String? role = await storage.read(key: 'role');
    return role == 'ADMIN';
  }

  Future<bool> isUser() async {
    String? role = await storage.read(key: 'role');
    return role == 'USER';
  }

  // Add more methods as required (register, getAllUsers, getYourProfile, etc.)
}