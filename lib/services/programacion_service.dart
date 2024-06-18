import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uniattendmovil/models/programacion_model.dart';

class ProgramacionService {
  static const String baseUrl = "http://10.0.2.2:8080";
  final storage = FlutterSecureStorage();

  Future<List<Programacion>> listarProgramacionesUsuario() async {
    final token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('$baseUrl/adminuser/programaciones/listar/usuario'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final data = jsonDecode(utf8.decode(response.bodyBytes));

    if (data['statusCode'] == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      List<dynamic> programacionList = data['programacionList'];
      
      List<Programacion> programaciones = programacionList.map((item) {
      
        return Programacion.fromJson(item);
      }).toList();
      return programaciones;
    } else {
      throw Exception('Failed to load programaciones');
    }
  }

    Future<List<Programacion>> clasesHoy() async {
    final token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('$baseUrl/adminuser/programacion/clasesDeHoy/usuario'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final data = jsonDecode(utf8.decode(response.bodyBytes));

    if (data['statusCode'] == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      List<dynamic> programacionList = data['programacionList'];

      List<Programacion> programaciones = programacionList.map((item) {
        return Programacion.fromJson(item);
      }).toList();

      return programaciones;
    } else {
      throw Exception('Failed to load classes today');
    }
  }


}