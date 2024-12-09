import 'package:mockin/exchange_transform/exchange_trans.dart';

class StockOrderDTO {
  final String excd, symb, orderQuantity, overseasOrderUnitPrice;

  StockOrderDTO({
    required this.excd,
    required this.symb,
    required this.orderQuantity,
    required this.overseasOrderUnitPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      "transactionId": ExchangeTrans.buyOrder[excd],
      "overseasExchangeCode": ExchangeTrans.orderTrade[excd],
      "productNumber": symb,
      "orderQuantity": orderQuantity,
      "overseasOrderUnitPrice": overseasOrderUnitPrice,
    };
  }
}
