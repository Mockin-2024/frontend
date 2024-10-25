import 'package:mockin/provider/exchange_trans.dart';

class StockOrderDTO {
  final String excd, symb, orderQuantity, overseasOrderUnitPrice, email;

  StockOrderDTO({
    required this.excd,
    required this.symb,
    required this.orderQuantity,
    required this.overseasOrderUnitPrice,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      "transactionId": ExchangeTrans.buyOrder[excd],
      "overseasExchangeCode": ExchangeTrans.orderTrade[excd],
      "productNumber": symb,
      "orderQuantity": orderQuantity,
      "overseasOrderUnitPrice": overseasOrderUnitPrice,
      "email": email,
    };
  }
}
