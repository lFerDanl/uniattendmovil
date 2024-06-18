import 'package:uniattendmovil/models/user_model.dart';

class Licencia {
  final int id;
  final String tipo;
  final String fechaInicio;
  final String fechaFin;
  final String estado;
  final User usuario;

  Licencia({
    required this.id,
    required this.tipo,
    required this.fechaInicio,
    required this.fechaFin,
    required this.estado,
    required this.usuario,
  });

  factory Licencia.fromJson(Map<String, dynamic> json) {
    return Licencia(
      id: json['id'],
      tipo: json['tipo'],
      fechaInicio: json['fechaInicio'],
      fechaFin: json['fechaFin'],
      estado: json['estado'],
      usuario: json['usuario'] != null ? User.fromJson(json['usuario']) : User(
        id: 0,
        email: '',
        name: '',
        city: '',
        role: '',
        telefono: '',
        direccion: '',
        ci: '',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipo': tipo,
      'fechaInicio': fechaInicio,
      'fechaFin': fechaFin,
      'estado': estado,
      'usuario': usuario.toJson(), // Asume que UserDTO tiene un método toJson
    };
  }
}