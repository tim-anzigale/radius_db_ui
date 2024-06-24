class User {
  final String id;
  final String firstName;
  final String lastName;
  final bool admin;
  final String profile;
  final String email;
  final String phone;
  final String username;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.admin,
    required this.profile,
    required this.email,
    required this.phone,
    required this.username,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      admin: json['admin'],
      profile: json['profile'],
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'first_name': firstName,
      'last_name': lastName,
      'admin': admin,
      'profile': profile,
      'email': email,
      'phone': phone,
      'username': username,
      'created_at': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
