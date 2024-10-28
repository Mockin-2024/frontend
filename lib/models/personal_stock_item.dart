class PersonalStockItem {
  final String name, // 종목명
      symb,
      amountGainsLosses, // 외화평가손익금액
      rateGainsLosses, // 평가손익율
      howMuchStock, // 해외잔고수량
      amountEvaluation, // 해외주식평가금액
      buyAverage, // 매입평균가격
      buyAmount, // 외화매입금액
      curPrice, // 현재가격
      currency; // 거래통화코드

  PersonalStockItem.fromJson(Map<String, dynamic> json)
      : name = json['ovrs_item_name'],
        symb = json['ovrs_pdno'],
        amountGainsLosses = json['frcr_evlu_pfls_amt'],
        rateGainsLosses = json['evlu_pfls_rt'],
        howMuchStock = json['ovrs_cblc_qty'],
        amountEvaluation = json['ovrs_stck_evlu_amt'],
        buyAverage = json['pchs_avg_pric'],
        buyAmount = json['frcr_pchs_amt1'],
        curPrice = json['now_pric2'],
        currency = json['tr_crcy_cd'];
}
