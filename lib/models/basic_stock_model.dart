class BasicStockModel {
  final String excd, name, symb, last, rate;

  BasicStockModel.fromJson(Map<String, dynamic> json)
      : excd = json['excd'],
        name = json['name'],
        symb = json['symb'],
        last = json['last'],
        rate = json['rate'];
}
