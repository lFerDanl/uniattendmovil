import 'package:uniattendmovil/models/aula_model.dart';
import 'package:uniattendmovil/models/horario_model.dart';
import 'package:uniattendmovil/models/modulo_model.dart';

class ProgramacionHorario {
  final int id;
  final Horario horario;
  final Modulo modulo;
  final Aula aula;

  ProgramacionHorario({
    required this.id,
    required this.horario,
    required this.modulo,
    required this.aula,
  });

  factory ProgramacionHorario.fromJson(Map<String, dynamic> json) {
    return ProgramacionHorario(
      id: json['id'],
      horario: Horario.fromJson(json['horario']),
      modulo: Modulo.fromJson(json['modulo']),
      aula: Aula.fromJson(json['aula']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'horario': horario.toJson(),
      'modulo': modulo.toJson(),
      'aula': aula.toJson(),
    };
  }
}