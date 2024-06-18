import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uniattendmovil/models/licencia_model.dart';

class LicenciaService {
  static const String baseUrl = "http://10.0.2.2:8080";
  final storage = FlutterSecureStorage();

  Future<void> guardarLicencia(Map<String, dynamic> registroLicencia) async {
    final baseUrl = "http://10.0.2.2:8080"; // Ajusta la URL base según tu configuración
    final token = await storage.read(key: 'token'); // Debes obtener el token de tu almacenamiento seguro

    final url = Uri.parse('$baseUrl/adminuser/licencia/guardar');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(registroLicencia),
      );
      print(response.body);

      final data = jsonDecode(response.body);
      if (data['statusCode'] == 200) {
        print('Licencia guardada correctamente');
      } else {
        throw Exception(data['message']);
      }
    } catch (error) { 
      throw error;
    }
  }

    Future<void> actualizarLicencia(int licenciaId, Map<String, dynamic> registroLicencia) async {
    final baseUrl = "http://10.0.2.2:8080"; // Ajusta la URL base según tu configuración
    final token = await storage.read(key: 'token'); // Debes obtener el token de tu almacenamiento seguro

    final url = Uri.parse('$baseUrl/adminuser/licencia/actualizar/$licenciaId');

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(registroLicencia),
      );

      final data = jsonDecode(response.body);
      if (data['statusCode'] == 200) {
        print('Licencia actualizada correctamente');
      } else {
        throw Exception(data['message']);
      }
    } catch (error) { 
      throw error;
    }
  }

  Future<Map<String, dynamic>> eliminarLicencia(String licenciaId) async {
    final token = await storage.read(key: 'token');
    final response = await http.delete(
      Uri.parse('$baseUrl/adminuser/licencia/eliminar/$licenciaId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final data = jsonDecode(response.body);
    if (data['statusCode'] == 200) {
      return data;
    } else {
      throw Exception(data['message']);
    }
  }

  Future<List<Licencia>> listarLicenciasUsuario() async {
    final token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('$baseUrl/adminuser/licencia/listar/usuario'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final data = jsonDecode(utf8.decode(response.bodyBytes));
    if (data['statusCode'] == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      List<dynamic> licenciaList = data['licenciaList'];
      
      List<Licencia> licencias = licenciaList.map((item) {
      
        return Licencia.fromJson(item);
      }).toList();
      return licencias;
    } else {
      throw Exception(data['message']);
    }
  }

  Future<Licencia> getLicenciaById(int licenciaId) async {
    final token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('$baseUrl/adminuser/licencia/$licenciaId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Licencia.fromJson(data['licencia']);
    } else {
      throw Exception('Failed to load licencia');
    }
  }
}