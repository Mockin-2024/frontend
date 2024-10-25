import 'package:flutter/material.dart';
import 'package:mockin/api/trade_api.dart';
import 'package:mockin/dto/trading/balance_dto.dart';
import 'package:mockin/dto/trading/psamount_dto.dart';
import 'package:mockin/dto/trading/stock_order_dto.dart';
import 'package:mockin/provider/exchange_trans.dart';
import 'package:mockin/widgets/alert.dart';

class BuyOrSell extends StatelessWidget {
  final String excd, stockName, stockSymb, stockPrice, stockRate;
  final bool buy;
  final myController = TextEditingController();

  BuyOrSell(
      {super.key,
      required this.excd,
      required this.stockName,
      required this.stockSymb,
      required this.stockPrice,
      required this.stockRate,
      required this.buy});

  Future<String> buyPressed() async {
    return await TradeApi.buyOrder(
      DTO: StockOrderDTO(
        excd: excd,
        symb: stockSymb,
        orderQuantity: myController.text,
        overseasOrderUnitPrice: stockPrice,
      ),
    );
  }

  Future<String> sellPressed(String sellM) async {
    return TradeApi.sellOrder(
      DTO: StockOrderDTO(
        excd: excd,
        symb: stockSymb,
        orderQuantity: myController.text,
        overseasOrderUnitPrice: sellM,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var sellMoney = '';
    final Future<List<String>> stockData = TradeApi.balanceHowMuch(
      DTO: BalanceDTO(
        overseasExchangeCode: ExchangeTrans.orderTrade[excd]!,
        transactionCurrencyCode: ExchangeTrans.transactionCurrency[excd]!,
      ),
      stockName: stockName,
    );
    var sign = ExchangeTrans.signExchange[excd];
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Column(
            children: [
              Text(
                stockName,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$stockPrice$sign  $stockRate%',
                    style: TextStyle(
                      color: stockRate[0] == '+' ? Colors.red : Colors.blue,
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        buy ? '구매할 가격' : '판매할 가격',
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      buy
                          ? Text(
                              '$stockPrice$sign',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : FutureBuilder(
                              future: stockData,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  sellMoney = double.parse(snapshot.data!.first)
                                      .toStringAsFixed(1);
                                  return Text(
                                    '$sellMoney$sign',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                } else {
                                  return const Text(
                                    '-',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                }
                              },
                            ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '수량',
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: buy ? '몇 주 구매할까요?' : '몇 주 판매할까요?',
                        ),
                        keyboardType: TextInputType.number,
                        controller: myController,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      buy
                          ? FutureBuilder(
                              future: TradeApi.psAmount(
                                DTO: PsamountDTO(
                                  excd: ExchangeTrans.orderTrade[excd]!,
                                  symb: stockSymb,
                                  unitPrice: stockPrice,
                                ),
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var howMany = snapshot.data;
                                  return Text(
                                    '구매 가능 ${double.parse(howMany[0]).toStringAsFixed(1)}$sign, 최대 ${howMany[1]}주',
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  );
                                } else {
                                  return const Text('');
                                }
                              },
                            )
                          : FutureBuilder(
                              future: stockData,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    '${snapshot.data!.last}주',
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  );
                                } else {
                                  return const Text(
                                    '-',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                }
                              },
                            ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: buy
                      ? () async {
                          String st = await buyPressed();
                          if (!context.mounted) return;
                          Navigator.pop(context);
                          Alert.showAlert(context, st, '');
                        }
                      : () async {
                          String st = await sellPressed(sellMoney);
                          if (!context.mounted) return;
                          Navigator.pop(context);
                          Alert.showAlert(context, st, '');
                        },
                  child: Text(
                    buy ? '구매' : '판매',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
