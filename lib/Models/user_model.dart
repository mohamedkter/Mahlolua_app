class User {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String image; 
  final String userType;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.image,
    required this.userType,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'image': image,
      'userType': userType,
    };
  }
}
