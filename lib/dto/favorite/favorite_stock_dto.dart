class FavoriteStockDTO {
  final String excd, symb;

  FavoriteStockDTO({
    required this.excd,
    required this.symb,
  });

  Map<String, dynamic> toJson() {
    return {
      'excd': excd,
      'symb': symb,
    };
  }
}
