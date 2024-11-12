class PaymentDayDTO {
  final String tradDt, ctxAreaNk, ctxAreaFk;

  PaymentDayDTO({
    required this.tradDt,
    this.ctxAreaNk = '',
    this.ctxAreaFk = '',
  });

  Uri convert(String baseUrl) {
    return Uri.parse(
        '$baseUrl?ctxAreaFk=$ctxAreaFk&ctxAreaNk=$ctxAreaNk&tradDt=$tradDt');
  }
}
