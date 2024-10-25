class PsamountDTO {
  final String excd, symb, unitPrice;

  PsamountDTO({
    required this.excd,
    required this.symb,
    required this.unitPrice,
  });

  Uri convert(String baseUrl) {
    return Uri.parse('$baseUrl?itemCode=$symb&'
        'overseasExchangeCode=$excd&overseasOrderUnitPrice=$unitPrice');
  }
}
