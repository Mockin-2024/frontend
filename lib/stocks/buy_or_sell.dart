import 'package:flutter/material.dart';
import 'package:mockin/api/basic_api.dart';
import 'package:mockin/api/trade_api.dart';
import 'package:mockin/dto/basic/current_price_dto.dart';
import 'package:mockin/dto/trading/balance_dto.dart';
import 'package:mockin/dto/trading/psamount_dto.dart';
import 'package:mockin/dto/trading/stock_order_dto.dart';
import 'package:mockin/exchange_transform/exchange_trans.dart';
import 'package:mockin/widgets/etc/alert.dart';

class BuyOrSell extends StatefulWidget {
  final String excd, stockName, stockSymb;
  final bool buy;

  const BuyOrSell({
    super.key,
    required this.excd,
    required this.stockName,
    required this.stockSymb,
    required this.buy,
  });

  @override
  State<BuyOrSell> createState() => _BuyOrSellState();
}

class _BuyOrSellState extends State<BuyOrSell> {
  final myController = TextEditingController();
  final userEnteredPrice = TextEditingController();
  double price = 0.0, rate = 0.0;

  Future<String> buyPressed() async {
    return await TradeApi.buyOrder(
      DTO: StockOrderDTO(
        excd: widget.excd,
        symb: widget.stockSymb,
        orderQuantity: myController.text,
        overseasOrderUnitPrice: userEnteredPrice.text,
      ),
    );
  }

  Future<String> sellPressed(String sellM) async {
    return TradeApi.sellOrder(
      DTO: StockOrderDTO(
        excd: widget.excd,
        symb: widget.stockSymb,
        orderQuantity: myController.text,
        overseasOrderUnitPrice: userEnteredPrice.text,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchingData();
  }

  void fetchingData() async {
    List<String> rst = await BasicApi.currentPrice(
      DTO: CurrentPriceDTO(
        excd: widget.excd,
        symb: widget.stockSymb,
      ),
    );
    price = double.parse(rst[0]);
    var pastPrice = double.parse(rst[1]);
    rate = (price - pastPrice) / pastPrice * 100;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var sellMoney = '';
    final Future<List<String>> stockData = TradeApi.balanceHowMuch(
      DTO: BalanceDTO(
        overseasExchangeCode: ExchangeTrans.orderTrade[widget.excd]!,
        transactionCurrencyCode:
            ExchangeTrans.transactionCurrency[widget.excd]!,
      ),
      stockName: widget.stockName,
    );
    var sign = ExchangeTrans.signExchange[widget.excd];
    userEnteredPrice.text = price.toStringAsFixed(3);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 65,
          ),
          Column(
            children: [
              Text(
                widget.stockName,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    rate < 0
                        ? '${price.toStringAsFixed(3)}$sign  ${rate.toStringAsFixed(2)}%'
                        : '$price$sign  +${rate.toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: rate < 0 ? Colors.blue : Colors.red,
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
                        widget.buy ? '구매할 가격' : '판매할 가격',
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      widget.buy
                          ? TextField(
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: '구매 가격',
                                suffix: Text(
                                  '$sign',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              controller: userEnteredPrice,
                            )
                          : FutureBuilder(
                              future: stockData,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  sellMoney = double.parse(snapshot.data!.first)
                                      .toStringAsFixed(1);
                                  userEnteredPrice.text = sellMoney;
                                  return TextField(
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: '판매 가격',
                                      suffix: Text(
                                        '$sign',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    controller: userEnteredPrice,
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
                          labelText: widget.buy ? '몇 주 구매할까요?' : '몇 주 판매할까요?',
                        ),
                        keyboardType: TextInputType.number,
                        controller: myController,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      widget.buy
                          ? FutureBuilder(
                              future: TradeApi.psAmount(
                                DTO: PsamountDTO(
                                  excd: ExchangeTrans.orderTrade[widget.excd]!,
                                  symb: widget.stockSymb,
                                  unitPrice: price.toStringAsFixed(3),
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
                  onPressed: widget.buy
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
                    widget.buy ? '구매' : '판매',
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
