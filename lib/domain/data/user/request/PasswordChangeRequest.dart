class PasswordChangeRequest {

  String password;

  PasswordChangeRequest({
    required this.password
  });

  Map<String, dynamic> toJson() {
    return {
      'password': password
    };
  }

}