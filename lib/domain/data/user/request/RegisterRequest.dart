class RegisterRequest {
  String username;
  String email;
  String password;

  RegisterRequest({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fullName': username,
      'password': password
    };
  }
}