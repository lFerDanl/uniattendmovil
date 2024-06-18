class User {
  final int id;
  final String email;
  final String name;
  final String city;
  final String role;
  final String telefono;
  final String direccion;
  final String ci;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.city,
    required this.role,
    required this.telefono,
    required this.direccion,
    required this.ci,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      city: json['city'],
      role: json['role'],
      telefono: json['telefono'],
      direccion: json['direccion'],
      ci: json['ci'],
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'city': city,
      'role': role,
      'telefono': telefono,
      'direccion': direccion,
      'ci': ci,
    };
  }
}