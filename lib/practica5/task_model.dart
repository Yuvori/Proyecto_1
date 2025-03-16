class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  /// **Convertir un usuario en un mapa**
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
