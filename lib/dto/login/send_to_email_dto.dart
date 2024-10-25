class SendToEmailDTO {
  final String email;

  SendToEmailDTO({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
