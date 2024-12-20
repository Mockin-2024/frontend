class HogaDataModel {
  final String open, // 시가
      high, // 고가
      low, // 저가
      buyPrice1, // 매수 호가 가격 1
      buyAmount1, // 매수 호가 수량 1
      buyPrice2,
      buyAmount2,
      buyPrice3,
      buyAmount3,
      buyPrice4,
      buyAmount4,
      buyPrice5,
      buyAmount5,
      buyPrice6,
      buyAmount6,
      buyPrice7,
      buyAmount7,
      buyPrice8,
      buyAmount8,
      buyPrice9,
      buyAmount9,
      buyPrice10,
      buyAmount10,
      sellPrice1, // 매도 호가 가격 1
      sellAmount1, // 매도 호가 수량 1
      sellPrice2,
      sellAmount2,
      sellPrice3,
      sellAmount3,
      sellPrice4,
      sellAmount4,
      sellPrice5,
      sellAmount5,
      sellPrice6,
      sellAmount6,
      sellPrice7,
      sellAmount7,
      sellPrice8,
      sellAmount8,
      sellPrice9,
      sellAmount9,
      sellPrice10,
      sellAmount10;

  HogaDataModel({
    this.open = '0.0',
    this.high = '0.0',
    this.low = '0.0',
    this.buyPrice1 = '0.0',
    this.buyAmount1 = '0.0',
    this.buyPrice2 = '0.0',
    this.buyAmount2 = '0.0',
    this.buyPrice3 = '0.0',
    this.buyAmount3 = '0.0',
    this.buyPrice4 = '0.0',
    this.buyAmount4 = '0.0',
    this.buyPrice5 = '0.0',
    this.buyAmount5 = '0.0',
    this.buyPrice6 = '0.0',
    this.buyAmount6 = '0.0',
    this.buyPrice7 = '0.0',
    this.buyAmount7 = '0.0',
    this.buyPrice8 = '0.0',
    this.buyAmount8 = '0.0',
    this.buyPrice9 = '0.0',
    this.buyAmount9 = '0.0',
    this.buyPrice10 = '0.0',
    this.buyAmount10 = '0.0',
    this.sellPrice1 = '0.0',
    this.sellAmount1 = '0.0',
    this.sellPrice2 = '0.0',
    this.sellAmount2 = '0.0',
    this.sellPrice3 = '0.0',
    this.sellAmount3 = '0.0',
    this.sellPrice4 = '0.0',
    this.sellAmount4 = '0.0',
    this.sellPrice5 = '0.0',
    this.sellAmount5 = '0.0',
    this.sellPrice6 = '0.0',
    this.sellAmount6 = '0.0',
    this.sellPrice7 = '0.0',
    this.sellAmount7 = '0.0',
    this.sellPrice8 = '0.0',
    this.sellAmount8 = '0.0',
    this.sellPrice9 = '0.0',
    this.sellAmount9 = '0.0',
    this.sellPrice10 = '0.0',
    this.sellAmount10 = '0.0',
  });

  HogaDataModel.fromJson(Map<String, dynamic> json)
      : open = json['output1']['open'],
        high = json['output1']['high'],
        low = json['output1']['low'],
        buyPrice1 = json['output2']['pbid1'],
        buyAmount1 = json['output2']['vbid1'],
        buyPrice2 = json['output2']['pbid2'],
        buyAmount2 = json['output2']['vbid2'],
        buyPrice3 = json['output2']['pbid3'],
        buyAmount3 = json['output2']['vbid3'],
        buyPrice4 = json['output2']['pbid4'],
        buyAmount4 = json['output2']['vbid4'],
        buyPrice5 = json['output2']['pbid5'],
        buyAmount5 = json['output2']['vbid5'],
        buyPrice6 = json['output2']['pbid6'],
        buyAmount6 = json['output2']['vbid6'],
        buyPrice7 = json['output2']['pbid7'],
        buyAmount7 = json['output2']['vbid7'],
        buyPrice8 = json['output2']['pbid8'],
        buyAmount8 = json['output2']['vbid8'],
        buyPrice9 = json['output2']['pbid9'],
        buyAmount9 = json['output2']['vbid9'],
        buyPrice10 = json['output2']['pbid10'],
        buyAmount10 = json['output2']['vbid10'],
        sellPrice1 = json['output2']['pask1'],
        sellAmount1 = json['output2']['vask1'],
        sellPrice2 = json['output2']['pask2'],
        sellAmount2 = json['output2']['vask2'],
        sellPrice3 = json['output2']['pask3'],
        sellAmount3 = json['output2']['vask3'],
        sellPrice4 = json['output2']['pask4'],
        sellAmount4 = json['output2']['vask4'],
        sellPrice5 = json['output2']['pask5'],
        sellAmount5 = json['output2']['vask5'],
        sellPrice6 = json['output2']['pask6'],
        sellAmount6 = json['output2']['vask6'],
        sellPrice7 = json['output2']['pask7'],
        sellAmount7 = json['output2']['vask7'],
        sellPrice8 = json['output2']['pask8'],
        sellAmount8 = json['output2']['vask8'],
        sellPrice9 = json['output2']['pask9'],
        sellAmount9 = json['output2']['vask9'],
        sellPrice10 = json['output2']['pask10'],
        sellAmount10 = json['output2']['vask10'];
}
