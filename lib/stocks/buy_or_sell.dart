import 'package:flutter/material.dart';

class Buy extends StatelessWidget {
  final String stockName, stockPrice, stockRate;
  final bool buy;
  final myController = TextEditingController();

  Buy(
      {super.key,
      required this.stockName,
      required this.stockPrice,
      required this.stockRate,
      required this.buy});

  void buyPressed() {
    var tmp = myController.text;
    if (tmp != '') {
      //var harmony = int.parse(tmp);
      // print(howmany);
      // api 수행
    } else {
      // print('no way');
    }
    print('>>> buy');
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
