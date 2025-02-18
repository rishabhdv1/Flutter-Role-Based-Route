class RoleCredentials {
  final String role;
  final String email;
  final String password;

  RoleCredentials({
    required this.role,
    required this.email,
    required this.password,
  });

  // Factory method to create RoleCredentials from a Map
  factory RoleCredentials.fromMap(Map<String, String> map) {
    return RoleCredentials(
      role: map['role']!,
      email: map['email']!,
      password: map['password']!,
    );
  }
}
