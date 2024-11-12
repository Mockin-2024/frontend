class CurrentPriceDTO {
  final String auth, excd, symb;

  CurrentPriceDTO({
    required this.excd,
    required this.symb,
    this.auth = '',
  });

  Uri convert(String baseUrl) {
    return Uri.parse('$baseUrl?AUTH=$auth&EXCD=$excd&SYMB=$symb');
  }
}
