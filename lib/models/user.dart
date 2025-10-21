// Model untuk merepresentasikan data pengguna/user
class User {
  final String id;
  final String username;
  final String role; // e.g., 'Admin', 'Presiden', 'Masyarakat'

  User({
    required this.id,
    required this.username,
    required this.role,
  });

  // Metode sederhana untuk konversi ke JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'role': role,
    };
  }
}
