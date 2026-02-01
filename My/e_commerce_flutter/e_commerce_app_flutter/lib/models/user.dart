class User {
  final String name;
  final String email;
  final String? profileImage;

  const User({
    required this.name,
    required this.email,
    this.profileImage,
  });
}
