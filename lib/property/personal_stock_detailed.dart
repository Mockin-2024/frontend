import 'package:flutter/material.dart';
import 'package:mockin/provider/exchange_trans.dart';
import 'package:mockin/stocks/stock_detail.dart';

class PersonalStockDetailed extends StatelessWidget {
  final String name, // 종목명
      symb, // 종목코드
      amountGainsLosses, // 외화평가손익금액
      rateGainsLosses, // 평가손익율
      howMuchStock, // 해외잔고수량
      amountEvaluation, // 해외주식평가금액
      buyAverage, // 매입평균가격
      buyAmount, // 외화매입금액
      curPrice, // 현재가격
      currency, // 거래통화코드
      excd, // 거래소
      sign; // 돈 마크

  const PersonalStockDetailed({
    super.key,
    required this.name,
    required this.symb,
    required this.amountGainsLosses,
    required this.rateGainsLosses,
    required this.howMuchStock,
    required this.amountEvaluation,
    required this.buyAverage,
    required this.buyAmount,
    required this.curPrice,
    required this.currency,
    required this.excd,
    required this.sign,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 60),
          Center(
            child: Text(
              '$name($excd/$symb)',
              style: const TextStyle(color: Colors.black),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '현재 가격 : $curPrice$sign',
                style: const TextStyle(color: Colors.black),
              ),
              Text(
                '통화 : $currency',
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '외화평가손익금액 : $amountGainsLosses$sign',
                style: const TextStyle(color: Colors.black),
              ),
              Text(
                '평가손익율 : $rateGainsLosses%',
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '보유 수량 : $howMuchStock$sign',
                style: const TextStyle(color: Colors.black),
              ),
              Text(
                '해외주식평가금액 : $amountEvaluation$sign',
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '매입평균가격 : $buyAverage$sign',
                style: const TextStyle(color: Colors.black),
              ),
              Text(
                '외화매입금액 : $buyAmount$sign',
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StockDetail(
                        excd: ExchangeTrans.trade[excd]!,
                        stockName: name,
                        stockSymb: symb,
                        stockPrice: curPrice,
                      ),
                    ),
                  );
                },
                child: const Text('해당 주식 상세 페이지로 이동')),
          ),
        ],
      ),
    );
  }
}
