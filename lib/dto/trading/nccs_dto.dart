class NccsDTO {
  final String overseasExchangeCode,
      sortOrder,
      continuousSearchCondition200,
      continuousSearchKey200,
      email;

  NccsDTO({
    required this.overseasExchangeCode,
    required this.sortOrder,
    required this.email,
    this.continuousSearchCondition200 = '',
    this.continuousSearchKey200 = '',
  });

  Uri convert(String baseUrl) {
    return Uri.parse(
        '$baseUrl?continuousSearchCondition200=$continuousSearchCondition200&continuousSearchKey200=$continuousSearchKey200&'
        'email=$email&overseasExchangeCode=$overseasExchangeCode&sortOrder=$sortOrder');
  }
}
