class Horario {
  final int id;
  final String dia;
  final String horarioInicio;
  final String horarioFin;

  Horario({
    required this.id,
    required this.dia,
    required this.horarioInicio,
    required this.horarioFin,
  });

  factory Horario.fromJson(Map<String, dynamic> json) {
    return Horario(
      id: json['id'],
      dia: json['dia'],
      horarioInicio: json['horarioInicio'],
      horarioFin: json['horarioFin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dia': dia,
      'horarioInicio': horarioInicio,
      'horarioFin': horarioFin,
    };
  }
}