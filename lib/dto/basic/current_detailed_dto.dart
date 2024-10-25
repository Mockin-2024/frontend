class CurrentDetailedDTO {
  final String AUTH, EXCD, SYMB;

  CurrentDetailedDTO({
    required this.EXCD,
    required this.SYMB,
    this.AUTH = '',
  });

  Uri convert(String baseUrl) {
    return Uri.parse('$baseUrl?AUTH=$AUTH&EXCD=$EXCD&SYMB=$SYMB');
  }
}
