class CcnlDTO {
  final String orderStartDate,
      orderEndDate,
      continuousSearchCondition200,
      continuousSearchKey200,
      transactionContinuation;

  CcnlDTO({
    required this.orderStartDate,
    required this.orderEndDate,
    this.continuousSearchCondition200 = '',
    this.continuousSearchKey200 = '',
    this.transactionContinuation = '',
  });

  Uri convert(String baseUrl) {
    return Uri.parse(
        '$baseUrl?continuousSearchCondition200=$continuousSearchCondition200&continuousSearchKey200=$continuousSearchKey200&'
        'orderEndDate=$orderEndDate&orderStartDate=$orderStartDate&transactionContinuation=$transactionContinuation');
  }
}
