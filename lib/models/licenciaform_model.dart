class LicenciaForm {
  String tipo = '';
  String fechaInicio = '';
  String fechaFin = '';

  LicenciaForm({
    required this.tipo,
    required this.fechaInicio,
    required this.fechaFin,
  });

  Map<String, dynamic> toJson() {
    return {
      'tipo': tipo,
      'fechaInicio': fechaInicio,
      'fechaFin': fechaFin,
    };
  }
}