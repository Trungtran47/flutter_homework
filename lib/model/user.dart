class User {
  final String email;
  final String password;

  User({required this.email, required this.password});

  // Chuyển từ đối tượng User sang JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  // Chuyển từ JSON sang đối tượng User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
    );
  }
}
