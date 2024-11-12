class BalanceDTO {
  final String overseasExchangeCode,
      transactionCurrencyCode,
      continuousSearchCondition200,
      continuousSearchKey200;

  BalanceDTO({
    required this.overseasExchangeCode,
    required this.transactionCurrencyCode,
    this.continuousSearchCondition200 = '',
    this.continuousSearchKey200 = '',
  });

  Uri convert(String baseUrl) {
    return Uri.parse(
        '$baseUrl?continuousSearchCondition200=$continuousSearchCondition200&continuousSearchKey200=$continuousSearchKey200&'
        'overseasExchangeCode=$overseasExchangeCode&transactionCurrencyCode=$transactionCurrencyCode');
  }
}
