class AsistenciaN {
  final int id;
  final String fecha;
  final String estado;
  final String hora;

  AsistenciaN({
    required this.id,
    required this.fecha,
    required this.estado,
    required this.hora,
  });

  factory AsistenciaN.fromJson(Map<String, dynamic> json) {
    return AsistenciaN(
      id: json['id'],
      fecha: json['fecha'],
      estado: json['estado'],
      hora: json['hora'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fecha': fecha,
      'estado': estado,
      'hora': hora,
    };
  }
}