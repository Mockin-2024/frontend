class IndexChartDTO {
  final String fidCondMrktDivCode,
      fidInputIscd,
      fidHourClsCode,
      fidPwDataIncuYn,
      email;

  IndexChartDTO({
    required this.fidCondMrktDivCode,
    required this.fidInputIscd,
    required this.fidHourClsCode,
    required this.fidPwDataIncuYn,
    required this.email,
  });

  Uri convert(String baseUrl) {
    return Uri.parse(
        '$baseUrl?email=$email&fidCondMrktDivCode=$fidCondMrktDivCode&'
        'fidHourClsCode=$fidHourClsCode&fidInputIscd=$fidInputIscd&fidPwDataIncuYn=$fidPwDataIncuYn');
  }
}
