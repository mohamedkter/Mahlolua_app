class User {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String ?userType;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.userType,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'userType': userType,
    };
  }
}
