class StockChartDTO {
  final String AUTH, EXCD, SYMB, NMIN, PINC, NEXT, NREC, FILL, KEYB, email;

  StockChartDTO({
    required this.EXCD,
    required this.SYMB,
    required this.NMIN,
    required this.PINC,
    required this.NREC,
    required this.email,
    this.FILL = '',
    this.KEYB = '',
    this.NEXT = '',
    this.AUTH = '',
  });

  Uri convert(String baseUrl) {
    return Uri.parse(
        '$baseUrl?AUTH=$AUTH&EXCD=$EXCD&FILL=$FILL&KEYB=$KEYB&NEXT=$NEXT&'
        'NMIN=$NMIN&NREC=$NREC&PINC=$PINC&SYMB=$SYMB&email=$email');
  }
}