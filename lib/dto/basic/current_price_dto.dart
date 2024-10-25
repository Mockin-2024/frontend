class CurrentPriceDTO {
  final String auth, excd, symb, email;

  CurrentPriceDTO({
    required this.excd,
    required this.symb,
    required this.email,
    this.auth = '',
  });

  Uri convert(String baseUrl) {
    return Uri.parse('$baseUrl?AUTH=$auth&EXCD=$excd&SYMB=$symb&email=$email');
  }
}
