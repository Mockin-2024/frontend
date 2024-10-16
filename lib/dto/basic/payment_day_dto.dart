class PaymentDayDTO {
  final String tradDt, ctxAreaNk, ctxAreaFk, email;

  PaymentDayDTO({
    required this.tradDt,
    required this.email,
    this.ctxAreaNk = '',
    this.ctxAreaFk = '',
  });

  Uri convert(String baseUrl) {
    return Uri.parse(
        '$baseUrl?ctxAreaFk=$ctxAreaFk&ctxAreaNk=$ctxAreaNk&email=$email&tradDt=$tradDt');
  }
}
