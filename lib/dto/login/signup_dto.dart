class SignupDTO {
  final String email, pw, name;

  SignupDTO({
    required this.email,
    required this.pw,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': pw,
      'name': name,
    };
  }
}
