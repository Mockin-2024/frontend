class TokenValidationDTO {
  final String email, token;

  TokenValidationDTO({
    required this.email,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'token': token,
    };
  }
}
