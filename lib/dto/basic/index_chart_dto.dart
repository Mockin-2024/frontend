class IndexChartDTO {
  final String fidCondMrktDivCode,
      fidInputIscd,
      fidHourClsCode,
      fidPwDataIncuYn;

  IndexChartDTO({
    required this.fidCondMrktDivCode,
    required this.fidInputIscd,
    required this.fidHourClsCode,
    required this.fidPwDataIncuYn,
  });

  Uri convert(String baseUrl) {
    return Uri.parse('$baseUrl?fidCondMrktDivCode=$fidCondMrktDivCode&'
        'fidHourClsCode=$fidHourClsCode&fidInputIscd=$fidInputIscd&fidPwDataIncuYn=$fidPwDataIncuYn');
  }
}
