class BasicStockModel {
  final String excd, name, symb, last, rate, toRateSort, valx, tvol, avol;

  BasicStockModel.fromJson(Map<String, dynamic> json)
      : excd = json['excd'],
        name = json['name'],
        symb = json['symb'],
        last = json['last'],
        rate = json['rate'], // 등락율
        toRateSort = json['rate'],
        valx = json['valx'], // 시가총액
        tvol = json['tvol'], // 거래량
        avol = json['avol']; // 거래대금
}
