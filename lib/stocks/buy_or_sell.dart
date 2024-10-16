import 'package:flutter/material.dart';
import 'package:mockin/afterlogin/user_email.dart';
import 'package:mockin/api/trade_api.dart';
import 'package:mockin/dto/trading/psamount_dto.dart';
import 'package:mockin/dto/trading/stock_order_dto.dart';
import 'package:mockin/provider/exchange_trans.dart';

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

  void buyPressed() {
    var tmp = myController.text;
    TradeApi.buyOrder(
      dto: StockOrderDTO(
        excd: excd,
        symb: stockSymb,
        orderQuantity: tmp,
        email: UserEmail().getEmail()!,
      ),
    );
  }

  void sellPressed() {
    print('>>> sell');
  }

  @override
  Widget build(BuildContext context) {
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
                    stockPrice,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    ' ($stockRate%)',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Container(
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
                      const Row(
                        children: [
                          Text(
                            '29,821원',
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '\$22.59',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
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
                        keyboardType: TextInputType.text,
                        controller: myController,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        buy ? '구매 가능 -원, 최대 -주' : '판매 가능 최대 -주',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {
                      TradeApi.psAmount(
                        DTO: PsamountDTO(
                            excd: ExchangeTrans.orderTrade[excd]!,
                            symb: stockSymb,
                            unitPrice: '100',
                            email: UserEmail().getEmail()!),
                      );
                    },
                    child: const Text(
                      '테스트',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: buy ? buyPressed : sellPressed,
                    child: Text(
                      buy ? '구매' : '판매',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
