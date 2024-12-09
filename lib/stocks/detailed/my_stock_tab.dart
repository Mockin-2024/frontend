import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mockin/api/trade_api.dart';
import 'package:mockin/dto/trading/ccnl_dto.dart';
import 'package:mockin/models/order_model.dart';
import 'package:mockin/widgets/order_list/order_list_item.dart';
import 'package:mockin/widgets/text/title_text.dart';

class MyStockTab extends StatelessWidget {
  const MyStockTab({
    super.key,
    required this.symb,
  });

  final String symb;

  @override
  Widget build(BuildContext context) {
    Future<List<OrderModel>> fetchData = TradeApi.ccnlMyStock(
      DTO: CcnlDTO(
        orderStartDate: '20241001',
        orderEndDate: DateFormat('yyyyMMdd').format(DateTime.now()),
      ),
      symb: symb,
    );
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(40, 5, 0, 10),
            child: Text(
              '주문 내역',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: fetchData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<OrderModel> li = snapshot.data!;
                    if (li.isEmpty) {
                      return const Center(
                        child: TitleText(tt: '주문한 내역이 없습니다.'),
                      );
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: li.length,
                        itemBuilder: (context, index) {
                          return OrderListItem(
                            name: li[index].name,
                            excd: li[index].excd,
                            symb: li[index].symb,
                            orderNum: li[index].orderNum,
                            buyOrSell: li[index].buyOrSell,
                            orderDate: li[index].orderDate,
                            orderTime: li[index].orderTime,
                            originOrderNum: li[index].originOrderNum,
                            price: li[index].price,
                            amount: li[index].amount,
                            currency: li[index].currency,
                            signed: li[index].signed,
                          );
                        });
                  }
                  return const Text('');
                }),
          ),
        ],
      ),
    );
  }
}
