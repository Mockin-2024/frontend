class KeyPairRegisterDTO {
  final String email, appKey, appSecret;

  KeyPairRegisterDTO({
    required this.email,
    required this.appKey,
    required this.appSecret,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'appKey': appKey,
      'appSecret': appSecret,
    };
  }
}
