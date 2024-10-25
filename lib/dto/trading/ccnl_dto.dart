class CcnlDTO {
  final String orderStartDate, orderEndDate;

  CcnlDTO({
    required this.orderStartDate,
    required this.orderEndDate,
  });

  Uri convert(String baseUrl) {
    return Uri.parse(
        '$baseUrl?orderEndDate=$orderEndDate&orderStartDate=$orderStartDate');
  }
}
