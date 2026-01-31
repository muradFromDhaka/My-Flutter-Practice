class User {
  int? id;
  String name;
  String email;
  int age;
  String gender;
  String dob;
  bool isActive;
  String? imagePath; // new field

  User({
    this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    required this.dob,
    required this.isActive,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age,
      'gender': gender,
      'dob': dob,
      'isActive': isActive ? 1 : 0,
      'imagePath': imagePath,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      age: map['age'],
      gender: map['gender'],
      dob: map['dob'],
      isActive: map['isActive'] == 1,
      imagePath: map['imagePath'],
    );
  }
}
