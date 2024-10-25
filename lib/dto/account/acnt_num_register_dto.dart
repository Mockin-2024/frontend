class AcntNumRegisterDTO {
  final String accountNumber;

  AcntNumRegisterDTO({
    required this.accountNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'accountNumber': accountNumber,
    };
  }
}
