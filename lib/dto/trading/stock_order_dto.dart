import 'package:mockin/exchange_transform/exchange_trans.dart';

class StockOrderDTO {
  final String excd, symb, orderQuantity, overseasOrderUnitPrice;

  StockOrderDTO({
    required this.excd,
    required this.symb,
    required this.orderQuantity,
    required this.overseasOrderUnitPrice,
  });

  Map<String, dynamic> toJson(bool isBuy) {
    return {
      "transactionId":
          isBuy ? ExchangeTrans.buyOrder[excd] : ExchangeTrans.sellOrder[excd],
      "overseasExchangeCode": ExchangeTrans.orderTrade[excd],
      "productNumber": symb,
      "orderQuantity": orderQuantity,
      "overseasOrderUnitPrice": overseasOrderUnitPrice,
    };
  }
}
