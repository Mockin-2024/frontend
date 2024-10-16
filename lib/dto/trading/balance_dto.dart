class BalanceDTO {
  final String overseasExchangeCode,
      transactionCurrencyCode,
      continuousSearchCondition200,
      continuousSearchKey200,
      email;

  BalanceDTO({
    required this.overseasExchangeCode,
    required this.transactionCurrencyCode,
    required this.email,
    this.continuousSearchCondition200 = '',
    this.continuousSearchKey200 = '',
  });

  Uri convert(String baseUrl) {
    return Uri.parse(
        '$baseUrl?continuousSearchCondition200=$continuousSearchCondition200&continuousSearchKey200=$continuousSearchKey200&'
        'email=$email&overseasExchangeCode=$overseasExchangeCode&transactionCurrencyCode=$transactionCurrencyCode');
  }
}
