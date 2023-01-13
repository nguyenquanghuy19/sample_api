class UserModel {
  final String email;
  final String firstName;
  final String lastName;
  final String token;

  UserModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      token: json['token'] as String,
    );
  }
}
