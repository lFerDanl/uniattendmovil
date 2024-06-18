class Modulo {
  final int id;
  final String nro;

  Modulo({
    required this.id,
    required this.nro,
  });

  factory Modulo.fromJson(Map<String, dynamic> json) {
    return Modulo(
      id: json['id'],
      nro: json['nro'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nro': nro,
    };
  }
}