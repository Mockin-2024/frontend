class CurrentDetailedDTO {
  final String AUTH, EXCD, SYMB, email;

  CurrentDetailedDTO({
    required this.EXCD,
    required this.SYMB,
    required this.email,
    this.AUTH = '',
  });

  Uri convert(String baseUrl) {
    return Uri.parse('$baseUrl?AUTH=$AUTH&EXCD=$EXCD&SYMB=$SYMB&email=$email');
  }
}
