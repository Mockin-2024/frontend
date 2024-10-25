class StockOwn {
  final String name, buyOrSell, odDate, odTime, amount, price;

  StockOwn.fromJson(Map<String, dynamic> json)
      : name = json['prdt_name'],
        buyOrSell = json['sll_buy_dvsn_cd_name'],
        odDate = json['ord_dt'],
        odTime = json['ord_tmd'],
        amount = json['ft_ord_qty'],
        price = json['ft_ord_unpr3'];
}
