class LoginDTO {
  final String email, pw;

  LoginDTO({
    required this.email,
    required this.pw,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': pw,
    };
  }
}
