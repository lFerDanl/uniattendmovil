import 'package:uniattendmovil/models/asistenciae_model.dart';
import 'package:uniattendmovil/models/carrera_model.dart';
import 'package:uniattendmovil/models/grupo_model.dart';
import 'package:uniattendmovil/models/materia_model.dart';
import 'package:uniattendmovil/models/programacionhorario_model.dart';
import 'package:uniattendmovil/models/user_model.dart';

class Programacion {
  int id;
  String cupos;
  Materia materia;
  Grupo grupo;
  User usuario;
  List<Carrera> carreras;
  List<ProgramacionHorario> programacionHorarios;
  AsistenciaE? asistencia;

  Programacion({
    required this.id,
    required this.cupos,
    required this.materia,
    required this.grupo,
    required this.usuario,
    required this.carreras,
    required this.programacionHorarios,
    this.asistencia,
  });

  factory Programacion.fromJson(Map<String, dynamic> json) {
    return Programacion(
      id: json['id'],
      cupos: json['cupos'],
      materia: json['materia'] != null ? Materia.fromJson(json['materia']) : Materia(id: 0, nombre: ''), // Ejemplo de cómo manejar si materia es null
      grupo: json['grupo'] != null ? Grupo.fromJson(json['grupo']) : Grupo(id: 0, nombre: ''), // Ejemplo de cómo manejar si grupo es null
      usuario: json['usuario'] != null ? User.fromJson(json['usuario']) : User(id: 0, email: '', name: '', city: '', role: '', telefono: '', direccion: '', ci: ''), // Ejemplo de cómo manejar si usuario es null
      carreras: json['carreras'] != null
          ? List<Carrera>.from(json['carreras'].map((x) => Carrera.fromJson(x)))
          : [],
      programacionHorarios: json['programacionHorarios'] != null
          ? List<ProgramacionHorario>.from(json['programacionHorarios'].map((x) => ProgramacionHorario.fromJson(x)))
          : [],
      asistencia: json['asistencia'] != null ? AsistenciaE.fromJson(json['asistencia']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cupos': cupos,
      'materia': materia.toJson(),
      'grupo': grupo.toJson(),
      'usuario': usuario.toJson(),
      'carreras': carreras.map((x) => x.toJson()).toList(),
      'programacionHorarios': programacionHorarios.map((x) => x.toJson()).toList(),
    };
  }
}