class PresentBalanceDTO {
  final String currencyDivisonCode,
      countryCode,
      marketCode,
      inquiryDivisionCode;

  PresentBalanceDTO({
    required this.currencyDivisonCode,
    required this.countryCode,
    required this.marketCode,
    required this.inquiryDivisionCode,
  });

  Uri convert(String baseUrl) {
    return Uri.parse(
        '$baseUrl?countryCode=$countryCode&currencyDivisionCode=$currencyDivisonCode&'
        'inquiryDivisionCode=$inquiryDivisionCode&marketCode=$marketCode');
  }
}
