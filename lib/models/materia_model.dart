class Materia {
  final int id;
  final String nombre;

  Materia({
    required this.id,
    required this.nombre,
  });

  factory Materia.fromJson(Map<String, dynamic> json) {
    return Materia(
      id: json['id'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }
}