class CancelCorrectionDTO {
  final String transactionId,
      overseasExchangeCode,
      productNumber,
      originalOrderNumber,
      cancelOrReviseCode,
      orderQuantity,
      overseasOrderPrice;

  CancelCorrectionDTO({
    required this.transactionId,
    required this.overseasExchangeCode,
    required this.productNumber,
    required this.originalOrderNumber,
    required this.cancelOrReviseCode,
    required this.orderQuantity,
    required this.overseasOrderPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'overseasExchangeCode': overseasExchangeCode,
      'productNumber': productNumber,
      'originalOrderNumber': originalOrderNumber,
      'cancelOrReviseCode': cancelOrReviseCode,
      'orderQuantity': orderQuantity,
      'overseasOrderPrice': overseasOrderPrice,
    };
  }
}
