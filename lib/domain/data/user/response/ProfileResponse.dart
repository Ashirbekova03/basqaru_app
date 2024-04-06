class ProfileViewModel {
  num id;
  String fullName;
  String email;
  double balance;
  String password;

  ProfileViewModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.balance,
    required this.password
  });


  factory ProfileViewModel.fromJson(Map<String, dynamic> json) {
    return ProfileViewModel(
      id: json['id'],
      fullName: json['fullName'] ?? "",
      email: json['email'],
      balance: json['balance'],
      password: json['password'],
    );
  }
}