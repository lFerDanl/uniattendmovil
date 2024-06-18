import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:uniattendmovil/models/user_model.dart';

class AuthService {
  final String baseUrl = "http://68.183.122.161:8080";
  final storage = FlutterSecureStorage();

  Future<String?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    final data = jsonDecode(response.body);

    if (data['statusCode'] == 200) {
      final token = data['token'];
      await storage.write(key: 'token', value: token); // Almacenar token de acceso
      await storage.write(key: 'refreshToken', value: data['refreshToken']); // Almacenar refresh token
      await storage.write(key: 'role', value: data['role']);
      return token;
    } else {
      throw Exception(data['message']);
    }
  }

  Future<User?> getYourProfile(String token) async {
    final url = Uri.parse('$baseUrl/adminuser/get-profile');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token', // Usar el token en el encabezado de autorización
        'Content-Type': 'application/json',
      },
    );
    final data = jsonDecode(response.body);
    if (data['statusCode'] == 200) {
      final data = jsonDecode(response.body);
      final user = User.fromJson(data['ourUsers']);
      return user;
    } else {
      throw Exception(data['message']);
    }
  }

  Future<User?> getUserById(String userId, String token) async {
  final url = Uri.parse('$baseUrl/user/$userId');
  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token', // Usar el token en el encabezado de autorización
      'Content-Type': 'application/json',
    },
  );
    final data = jsonDecode(response.body);
    if (data['statusCode'] == 200) {
    final data = jsonDecode(response.body);
    final user = User.fromJson(data['ourUsers']);
    return user;
  } else {
    throw Exception(data['message']);
  }
}

  Future<void> logout() async {
    await storage.deleteAll();
  }

  Future<bool> isAuthenticated() async {
    final token = await storage.read(key: 'token');
    return token != null;
  }

  Future<bool> isAdmin() async {
    final role = await storage.read(key: 'role');
    return role == 'ADMIN';
  }

  Future<bool> isUser() async {
    final role = await storage.read(key: 'role');
    return role == 'USER';
  }

  Future<User?> getProfile() async {
    final token = await storage.read(key: 'token');
    if (token == null) {
      throw Exception('No token found');
    }

    final url = Uri.parse('$baseUrl/adminuser/get-profile');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data['ourUsers']);
    } else {
      throw Exception('Failed to fetch profile');
    }
  }

  Future<void> refreshToken() async {
    final refreshToken = await storage.read(key: 'refreshToken');
    if (refreshToken == null) {
      throw Exception('No refresh token found');
    }

    final url = Uri.parse('$baseUrl/auth/refresh');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await storage.write(key: 'token', value: data['token']);
      await storage.write(key: 'refreshToken', value: data['refreshToken']);
    } else {
      throw Exception('Failed to refresh token');
    }
  }
}
