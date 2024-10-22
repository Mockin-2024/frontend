class PersonalStockItem {
  final String name,
      stockAmount,
      avgPrice,
      howMuchStock,
      pOrlamount,
      overseasStockAmount,
      pOrlrate,
      nowPrice;

  PersonalStockItem.fromJson(Map<String, dynamic> json)
      : name = json['ovrs_item_name'], // 해외종목명
        stockAmount = json['ovrs_cblc_qty'], // 해외잔고수량
        avgPrice = json['pchs_avg_pic'], // 매입평균가격
        howMuchStock = json['frcr_pchs_amt1'], // 외화매입금액
        pOrlamount = json['frcr_evlu_pfls_amt'], // 외화평가손익금액
        overseasStockAmount = json['ovrs_stck_evlu_amt'], // 해외주식평가금액
        pOrlrate = json['evlu_pfls_rt'], // 평가손익율
        nowPrice = json['now_pric2']; // 현재 가격
}
