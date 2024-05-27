class PasswordChangeRequest {

  String password;
  String oldPassword;

  PasswordChangeRequest({
    required this.password,
    required this.oldPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'oldPassword': oldPassword,
    };
  }

}