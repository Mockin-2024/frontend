class CcnlDTO {
  final String orderStartDate, orderEndDate, email;

  CcnlDTO({
    required this.orderStartDate,
    required this.orderEndDate,
    required this.email,
  });

  Uri convert(String baseUrl) {
    return Uri.parse(
        'email=$email&orderEndDate=$orderEndDate&orderStartDate=$orderStartDate');
  }
}
