import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uniattendmovil/models/asistenciae_model.dart';
import 'package:uniattendmovil/models/asistencian_model.dart';
import 'package:uniattendmovil/models/licencia_model.dart';


class AsistenciaService {
  static const String baseUrl = "http://10.0.2.2:8080";
  final storage = FlutterSecureStorage();

  Future<AsistenciaE?> getAsistenciaHoy(int programacionHorarioId) async {
    final token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('$baseUrl/adminuser/asistenciahoy/$programacionHorarioId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final data = jsonDecode(response.body);

    if (data['statusCode'] == 200) {
      final data = jsonDecode(response.body);
      final asistencia = AsistenciaE.fromJson(data['asistencia']);
      return asistencia;
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
    final data = jsonDecode(response.body);
    
    if (data['statusCode'] == 200) {
      final data = jsonDecode(response.body);
      return Licencia.fromJson(data);
    } else {
      throw Exception('Failed to load licencia');
    }
  }
  
  Future<List<AsistenciaN>> listarAsistenciasUsuario() async {
    final token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('$baseUrl/adminuser/asistencia/listar/usuario'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final data = jsonDecode(utf8.decode(response.bodyBytes));

    if (data['statusCode'] == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      List<dynamic> asistenciaList = data['asistenciaList'];
      
      List<AsistenciaN> asistencias = asistenciaList.map((item) {
      
        return AsistenciaN.fromJson(item);
      }).toList();
      print (asistencias);
      return asistencias;
    } else {
      throw Exception(data['message']);
    }
  }
  Future<void> registrarAsistencia(String programacionHorarioId) async {
    final token = await storage.read(key: 'token');
    final response = await http.post(
      Uri.parse('$baseUrl/adminuser/asistencia/registrar/$programacionHorarioId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {},
    );
    final data = jsonDecode(response.body);
    if (data['statusCode'] == 200) {
    } else {
      throw Exception(data['message']);
    }
  }
}
