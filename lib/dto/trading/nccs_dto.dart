class NccsDTO {
  final String overseasExchangeCode,
      sortOrder,
      continuousSearchCondition200,
      continuousSearchKey200;

  NccsDTO({
    required this.overseasExchangeCode,
    required this.sortOrder,
    this.continuousSearchCondition200 = '',
    this.continuousSearchKey200 = '',
  });

  Uri convert(String baseUrl) {
    return Uri.parse(
        '$baseUrl?continuousSearchCondition200=$continuousSearchCondition200&continuousSearchKey200=$continuousSearchKey200&'
        'overseasExchangeCode=$overseasExchangeCode&sortOrder=$sortOrder');
  }
}
