class StockOrderDTO {
  final String excd, symb, orderQuantity, overseasOrderUnitPrice, email;

  StockOrderDTO({
    required this.excd,
    required this.symb,
    required this.orderQuantity,
    required this.overseasOrderUnitPrice,
    required this.email,
  });
}
