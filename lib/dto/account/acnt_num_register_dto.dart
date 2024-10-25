class AcntNumRegisterDTO {
  final String email, accountNumber;

  AcntNumRegisterDTO({
    required this.email,
    required this.accountNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'accountNumber': accountNumber,
    };
  }
}
