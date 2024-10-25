class PsamountDTO {
  final String excd, symb, unitPrice, email;

  PsamountDTO({
    required this.excd,
    required this.symb,
    required this.unitPrice,
    required this.email,
  });

  Uri convert(String baseUrl) {
    return Uri.parse('$baseUrl?email=$email&itemCode=$symb&'
        'overseasExchangeCode=$excd&overseasOrderUnitPrice=$unitPrice');
  }
}
