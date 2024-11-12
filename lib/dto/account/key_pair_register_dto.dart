class KeyPairRegisterDTO {
  final String appKey, appSecret;

  KeyPairRegisterDTO({
    required this.appKey,
    required this.appSecret,
  });

  Map<String, dynamic> toJson() {
    return {
      'appKey': appKey,
      'appSecret': appSecret,
    };
  }
}
