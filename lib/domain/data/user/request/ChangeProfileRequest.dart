class ChangeProfileRequest {
  String username;
  String email;

  ChangeProfileRequest({
    required this.username,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
    };
  }
}