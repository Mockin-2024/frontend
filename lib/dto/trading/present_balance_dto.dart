class PresentBalanceDTO {
  final String currencyDivisonCode,
      countryCode,
      marketCode,
      inquiryDivisionCode,
      email;

  PresentBalanceDTO({
    required this.currencyDivisonCode,
    required this.countryCode,
    required this.marketCode,
    required this.inquiryDivisionCode,
    required this.email,
  });

  Uri convert(String baseUrl) {
    return Uri.parse(
        '$baseUrl?countryCode=$countryCode&currencyDivisionCode=$currencyDivisonCode&'
        'email=$email&inquiryDivisionCode=$inquiryDivisionCode&marketCode=$marketCode');
  }
}
