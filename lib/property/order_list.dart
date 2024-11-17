import 'package:flutter/material.dart';
import 'package:mockin/api/trade_api.dart';
import 'package:mockin/dto/trading/ccnl_dto.dart';
import 'package:mockin/models/order_model.dart';
import 'package:intl/intl.dart';
import 'package:mockin/widgets/order_list_item.dart';

class OrderList extends StatefulWidget {
  const OrderList({
    super.key,
  });

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List<OrderModel> orders = []; // 주문 내역을 저장할 리스트
  String key = '';
  bool first = true;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchOrders();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchOrders();
      }
    });
  }

  Future<void> fetchOrders() async {
    print('>>> 주문 체결 first:\'$first\' key:\'$key\'');
    if (!first && key == '') return;
    setState(() {
      isLoading = true;
    });

    List<dynamic> newOrders;
    if (key == '') {
      newOrders = await TradeApi.ccnl(
        DTO: CcnlDTO(
          orderStartDate: '20241001',
          orderEndDate: DateFormat('yyyyMMdd').format(DateTime.now()),
        ),
      );
    } else {
      newOrders = await TradeApi.ccnl(
        DTO: CcnlDTO(
          orderStartDate: '20241001',
          orderEndDate: DateFormat('yyyyMMdd').format(DateTime.now()),
          continuousSearchKey200: key,
          transactionContinuation: 'N',
        ),
      );
    }
    print('>>> key ${newOrders[1]}');
    setState(() {
      orders.addAll(newOrders[0]);
      key = newOrders[1];
      first = false;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 60,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(40, 0, 0, 10),
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
            child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount:
                    orders.length + (isLoading ? 1 : 0), // 받아올 데이터가 있으면 1칸 추가
                itemBuilder: (context, index) {
                  if (index == orders.length) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  }
                  return OrderListItem(
                    name: orders[index].name,
                    excd: orders[index].excd,
                    symb: orders[index].symb,
                    orderNum: orders[index].orderNum,
                    buyOrSell: orders[index].buyOrSell,
                    orderDate: orders[index].orderDate,
                    orderTime: orders[index].orderTime,
                    originOrderNum: orders[index].originOrderNum,
                    price: orders[index].price,
                    amount: orders[index].amount,
                    currency: orders[index].currency,
                    signed: orders[index].signed,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
