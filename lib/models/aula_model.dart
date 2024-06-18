class Aula {
  final int id;
  final String nro;
  final String capacidad;

  Aula({
    required this.id,
    required this.nro,
    required this.capacidad,
  });

  factory Aula.fromJson(Map<String, dynamic> json) {
    return Aula(
      id: json['id'],
      nro: json['nro'],
      capacidad: json['capacidad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nro': nro,
      'capacidad': capacidad,
    };
  }
}