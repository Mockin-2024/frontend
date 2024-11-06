import 'package:flutter/material.dart';
import 'package:mockin/api/trade_api.dart';
import 'package:mockin/dto/trading/cancel_correction_dto.dart';
import 'package:mockin/provider/exchange_trans.dart';
import 'package:mockin/stocks/stock_detail.dart';
import 'package:mockin/widgets/alert.dart';
import 'package:mockin/widgets/text_input.dart';

class OrderDetailed extends StatelessWidget {
  OrderDetailed({
    super.key,
    required this.name,
    required this.excd,
    required this.symb,
    required this.orderNum,
    required this.buyOrSell,
    required this.orderDate,
    required this.orderTime,
    required this.originOrderNum,
    required this.price,
    required this.amount,
    required this.currency,
    required this.signed,
  });

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

  final TextEditingController pText = TextEditingController(); // 가격 컨트롤러
  final TextEditingController aText = TextEditingController(); // 수량 컨트롤러

  Future<bool> canCorOrder({
    required bool state,
  }) async {
    bool rst = await TradeApi.cancelCorrection(
      DTO: CancelCorrectionDTO(
        transactionId:
            ExchangeTrans.canCorTrans[ExchangeTrans.orderTradeReverse[excd]]!,
        overseasExchangeCode: excd,
        productNumber: symb,
        originalOrderNumber: orderNum,
        cancelOrReviseCode: state ? '01' : '02',
        orderQuantity: state ? aText.text : amount,
        overseasOrderPrice: state ? pText.text : price,
      ),
    );
    return rst;
  }

  void showOrderDialog({
    required BuildContext context,
    required bool state,
    required String name,
    required String price,
    required String amount,
    required String orderNum,
    required String sign,
    required String excd,
    required String symb,
  }) {
    // state : true (정정) / false (취소)
    pText.text = double.parse(price).toStringAsFixed(3);
    aText.text = amount;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  state ? '정정' : '취소',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.close,
                  ),
                ),
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '아래의 주문을\n${state ? '정정' : '취소'} 하시겠습니까?',
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                    },
                    children: [
                      TableRow(children: [
                        const TableCell(
                          child: Text(
                            '종목명',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Text(
                            name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Text(
                            state ? '주문가격($sign)' : '주문가격',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TableCell(
                          child: state
                              ? TextInput(name: '가격 입력', tec: pText)
                              : Text(
                                  '${double.parse(price).toStringAsFixed(3)}$sign',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Text(
                            state ? '주문수량(주)' : '주문수량',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TableCell(
                          child: state
                              ? TextInput(name: '수량 입력', tec: aText)
                              : Text(
                                  '$amount주',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: state
                          ? () async {
                              bool rst = await canCorOrder(state: true);
                              print('>>> $orderNum');
                              if (!context.mounted) return;
                              if (rst) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Alert.showAlert(context, '정정', '성공!');
                                return;
                              }
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Alert.showAlert(context, '정정', '실패');
                              return;
                            }
                          : () async {
                              bool rst = await canCorOrder(state: false);
                              if (!context.mounted) return;
                              if (rst) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Alert.showAlert(context, '정정', '성공!');
                                return;
                              }
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Alert.showAlert(context, '정정', '실패');
                              return;
                            },
                      child: Text(
                        '${state ? '정정' : '취소'}하기',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Center(
                child: Text(
                  '$name $buyOrSell',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Text(
              '$signed (${ExchangeTrans.orderTradeReverse[excd]}/$symb/$currency)',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '$buyOrSell ${(signed == '체결') ? '완료' : '대기'}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${orderDate.substring(0, 4)}.${orderDate.substring(4, 6)}.${orderDate.substring(6, 8)}  ${orderTime.substring(0, 2)}:${orderTime.substring(2, 4)}:${orderTime.substring(4, 6)}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '1주 가격',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '${double.parse(price).toStringAsFixed(3)}${ExchangeTrans.signExchange[ExchangeTrans.orderTradeReverse[excd]]}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '수량',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '$amount주',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StockDetail(
                              excd: ExchangeTrans.orderTradeReverse[excd]!,
                              stockName: name,
                              stockSymb: symb,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        '$name 보기',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: (signed == '미체결')
                          ? () {
                              showOrderDialog(
                                context: context,
                                state: true,
                                name: name,
                                price: price,
                                amount: amount,
                                orderNum: orderNum,
                                sign: ExchangeTrans.signExchange[
                                    ExchangeTrans.orderTradeReverse[excd]]!,
                                excd: excd,
                                symb: symb,
                              );
                            }
                          : null,
                      child: Text(
                        '정정',
                        style: TextStyle(
                          color: (signed == '미체결')
                              ? Colors.black
                              : Colors.black.withOpacity(0.5),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: (signed == '미체결')
                          ? () {
                              showOrderDialog(
                                context: context,
                                state: false,
                                name: name,
                                price: price,
                                amount: amount,
                                orderNum: orderNum,
                                sign: ExchangeTrans.signExchange[
                                    ExchangeTrans.orderTradeReverse[excd]]!,
                                excd: excd,
                                symb: symb,
                              );
                            }
                          : null,
                      child: Text(
                        '취소',
                        style: TextStyle(
                          color: (signed == '미체결')
                              ? Colors.black
                              : Colors.black.withOpacity(0.5),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
