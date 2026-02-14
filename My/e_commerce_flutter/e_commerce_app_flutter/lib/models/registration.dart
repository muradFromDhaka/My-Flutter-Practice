class Registration {
  final String username;
  final String password;
  final String email;
  final String firstName;
  final String lastName;

  Registration({
    required this.username,
    required this.password,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  /// Convert object to JSON (for API requests)
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  /// Create object from JSON (optional but recommended)
  factory Registration.fromJson(Map<String, dynamic> json) {
    return Registration(
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }

  @override
  String toString() {
    return 'RegisterRequest(username: $username, email: $email, firstName: $firstName, lastName: $lastName)';
  }
}
