class User {
  int? id;
  String name;
  String email;
  String phone;
  String address;
  int age;
  double salary;
  Gender gender;
  String department; // new field
  DateTime dob;
  DateTime createdAt;
  bool isActive;
  List<String> skills;
  String? imagePath;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.age,
    required this.salary,
    required this.gender,
    required this.department, // new
    required this.dob,
    required this.createdAt,
    required this.isActive,
    required this.skills,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'age': age,
      'salary': salary,
      'gender': gender.index, // store as int
      'department': department,
      'dob': dob.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive ? 1 : 0,
      'skills': skills.join(','), // store as comma-separated
      'imagePath': imagePath,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      age: map['age'],
      salary: map['salary'],
      gender: Gender.values[map['gender']],
      department: map['department'] ?? '',
      dob: DateTime.parse(map['dob']),
      createdAt: DateTime.parse(map['createdAt']),
      isActive: map['isActive'] == 1,
      skills: map['skills'] != null && map['skills'] != ''
          ? (map['skills'] as String).split(',')
          : [],
      imagePath: map['imagePath'],
    );
  }
}

enum Gender { male, female, other }
