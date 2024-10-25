class CancelCorrectionDTO {
  final String email,
      transactionId,
      overseasExchangeCode,
      productNumber,
      originalOrderNumber,
      cancelOrReviseCode,
      orderQuantity,
      overseasOrderPrice;

  CancelCorrectionDTO({
    required this.email,
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
      'email': email,
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
