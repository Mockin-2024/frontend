class YearDTO {
  final String fidCondMrktDivCode,
      fidInputDate1,
      fidInputDate2,
      fidInputIscd,
      fidPeriodDivCode,
      email;

  YearDTO({
    required this.fidInputDate1,
    required this.fidInputDate2,
    required this.fidInputIscd,
    required this.fidPeriodDivCode,
    required this.email,
    this.fidCondMrktDivCode = 'N',
  });

  Uri convert(String baseUrl) {
    return Uri.parse(
        '$baseUrl?email=$email&fidCondMrktDivCode=$fidCondMrktDivCode&fidInputDate1=$fidInputDate1&'
        'fidInputDate2=$fidInputDate2&fidInputIscd=$fidInputIscd&fidPeriodDivCode=$fidPeriodDivCode');
  }
}
