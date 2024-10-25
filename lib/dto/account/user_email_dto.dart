class UserEmailDTO {
  final String email;

  UserEmailDTO({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
    };
  }
}
