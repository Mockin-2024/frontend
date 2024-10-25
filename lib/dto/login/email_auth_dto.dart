class EmailAuthDTO {
  final String email, authNum;

  EmailAuthDTO({
    required this.email,
    required this.authNum,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'authNum': authNum,
    };
  }
}
