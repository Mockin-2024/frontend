class TenHogaDTO {
  TenHogaDTO({
    required this.excd,
    required this.symb,
    this.AUTH = '',
  });

  final String excd, symb, AUTH;

  Uri convert(String baseUrl) {
    return Uri.parse('$baseUrl?AUTH=$AUTH&EXCD=$excd&SYMB=$symb');
  }
}
