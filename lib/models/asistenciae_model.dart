class AsistenciaE {
  final String estado;

  AsistenciaE({
    required this.estado,
  });

  factory AsistenciaE.fromJson(Map<String, dynamic> json) {
    return AsistenciaE(
      estado: json['estado'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'estado': estado,
    };
  }
}