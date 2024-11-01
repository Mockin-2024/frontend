class OrderModel {
  final String name, // 종목명
      excd, // 거래소
      symb, // 종목코드
      orderNum, // 주문#
      buyOrSell, // 매매구분
      orderDate, // 주문일자
      orderTime, // 주문시간
      originOrderNum, // 원주문#
      price, // 체결가격 or 주문가격
      amount, // 체결수량 or 미체결수량
      currency, // 통화 코드
      signed; // 체결/미체결

  // 체결
  OrderModel.fromJson1(Map<String, dynamic> json)
      : name = json['prdt_name'],
        excd = json['ovrs_excg_cd'],
        symb = json['pdno'],
        orderNum = json['odno'],
        buyOrSell = json['sll_buy_dvsn_cd_name'],
        orderDate = json['dmst_ord_dt'],
        orderTime = json['thco_ord_tmd'],
        originOrderNum = json['orgn_odno'],
        price = json['ft_ccld_unpr3'],
        amount = json['ft_ccld_qty'],
        currency = json['tr_crcy_cd'],
        signed = '체결';

  // 미체결
  OrderModel.fromJson2(Map<String, dynamic> json)
      : name = json['prdt_name'],
        excd = json['ovrs_excg_cd'],
        symb = json['pdno'],
        orderNum = json['odno'],
        buyOrSell = json['sll_buy_dvsn_cd_name'],
        orderDate = json['dmst_ord_dt'],
        orderTime = json['thco_ord_tmd'],
        originOrderNum = json['orgn_odno'],
        price = json['ft_ord_unpr3'],
        amount = json['nccs_qty'],
        currency = json['tr_crcy_cd'],
        signed = '미체결';
}
