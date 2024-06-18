import 'package:uniattendmovil/models/facultad_model.dart';

class Carrera {
  final int id;
  final String nombre;
  final Facultad facultad;

  Carrera({
    required this.id,
    required this.nombre,
    required this.facultad,
  });

  factory Carrera.fromJson(Map<String, dynamic> json) {
    return Carrera(
      id: json['id'],
      nombre: json['nombre'],
      facultad: json['facultad'] != null ? Facultad.fromJson(json['facultad']) : Facultad(id: 0, nombre: ''), // Ejemplo de cómo manejar si facultad es null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'facultad': facultad.toJson(),
    };
  }
}