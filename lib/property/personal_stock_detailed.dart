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
      appBar: AppBar(
        flexibleSpace: Container(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Center(
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Text(
                  '($excd/$symb)',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Table(
                children: [
                  TableRow(children: [
                    TableElement(
                      category: '현재 가격',
                      value: double.parse(curPrice).toStringAsFixed(3),
                      sign: sign,
                    ),
                    TableElement(
                      category: '통화',
                      value: currency,
                      sign: '',
                    ),
                  ]),
                  TableRow(children: [
                    TableElement(
                      category: '외화평가손익금액',
                      value: double.parse(amountGainsLosses).toStringAsFixed(2),
                      sign: sign,
                    ),
                    TableElement(
                      category: '평가손익율',
                      value: double.parse(rateGainsLosses).toStringAsFixed(2),
                      sign: '%',
                    ),
                  ]),
                  TableRow(children: [
                    TableElement(
                      category: '보유 수량',
                      value: howMuchStock,
                      sign: '주',
                    ),
                    TableElement(
                      category: '해외주식평가금액',
                      value: double.parse(amountEvaluation).toStringAsFixed(2),
                      sign: sign,
                    ),
                  ]),
                  TableRow(children: [
                    TableElement(
                      category: '매입평균가격',
                      value: double.parse(buyAverage).toStringAsFixed(3),
                      sign: sign,
                    ),
                    TableElement(
                      category: '외화매입금액',
                      value: double.parse(buyAmount).toStringAsFixed(3),
                      sign: sign,
                    ),
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 30),
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
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.black),
                ),
                child: Text(
                  '$name 보기',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('- 현재 가격 : 선택 주식의 현재 가격',
                style: TextStyle(color: Colors.black)),
            const SizedBox(height: 5),
            const Text('- 통화 : 선택 주식의 화폐',
                style: TextStyle(color: Colors.black)),
            const SizedBox(height: 5),
            const Text('- 외화평가손익금액 : 매수 이후 총 손익',
                style: TextStyle(color: Colors.black)),
            const SizedBox(height: 5),
            const Text('- 평가손익율 : 매수 이후 손익율',
                style: TextStyle(color: Colors.black)),
            const SizedBox(height: 5),
            const Text('- 보유수량 : 현재 보유한 주식 수량',
                style: TextStyle(color: Colors.black)),
            const SizedBox(height: 5),
            const Text('- 해외주식평가금액 : 현재 가격 X 보유수량',
                style: TextStyle(color: Colors.black)),
            const SizedBox(height: 5),
            const Text('- 매입평균가격 : 매수 했을 때의 가격 평균',
                style: TextStyle(color: Colors.black)),
            const SizedBox(height: 5),
            const Text('- 외화매입금액 : 매입평균가격 X 보유수량',
                style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

class TableElement extends StatelessWidget {
  const TableElement({
    super.key,
    required this.category,
    required this.value,
    required this.sign,
  });

  final String category, value, sign;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Text(
              category,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              '$value$sign',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
