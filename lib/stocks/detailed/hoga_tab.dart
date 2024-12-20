import 'package:flutter/material.dart';
import 'package:mockin/api/basic_api.dart';
import 'package:mockin/dto/basic/ten_hoga_dto.dart';
import 'package:mockin/models/hoga_data_model.dart';
import 'package:mockin/exchange_transform/exchange_trans.dart';
import 'package:mockin/widgets/stock_detailed/hoga/lower_hoga.dart';
import 'package:mockin/widgets/stock_detailed/hoga/upper_price.dart';

class HogaTab extends StatelessWidget {
  const HogaTab({
    super.key,
    required this.curPrice,
    required this.excd,
    required this.symb,
  });

  final String curPrice, excd, symb;

  @override
  Widget build(BuildContext context) {
    var sign = ExchangeTrans.signExchange[excd];
    Future<dynamic> fetchData = BasicApi.tenHoga(
      DTO: TenHogaDTO(
        excd: excd,
        symb: symb,
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: fetchData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    HogaDataModel dt = snapshot.data!;
                    Map<int, List<dynamic>> hoga = {
                      0: [
                        dt.sellPrice10,
                        dt.sellAmount10 != '' ? dt.sellAmount10 : '0',
                        true
                      ],
                      1: [
                        dt.sellPrice9,
                        dt.sellAmount9 != '' ? dt.sellAmount9 : '0',
                        true
                      ],
                      2: [
                        dt.sellPrice8,
                        dt.sellAmount8 != '' ? dt.sellAmount8 : '0',
                        true
                      ],
                      3: [
                        dt.sellPrice7,
                        dt.sellAmount7 != '' ? dt.sellAmount7 : '0',
                        true
                      ],
                      4: [
                        dt.sellPrice6,
                        dt.sellAmount6 != '' ? dt.sellAmount6 : '0',
                        true
                      ],
                      5: [
                        dt.sellPrice5,
                        dt.sellAmount5 != '' ? dt.sellAmount5 : '0',
                        true
                      ],
                      6: [
                        dt.sellPrice4,
                        dt.sellAmount4 != '' ? dt.sellAmount4 : '0',
                        true
                      ],
                      7: [
                        dt.sellPrice3,
                        dt.sellAmount3 != '' ? dt.sellAmount3 : '0',
                        true
                      ],
                      8: [
                        dt.sellPrice2,
                        dt.sellAmount2 != '' ? dt.sellAmount2 : '0',
                        true
                      ],
                      9: [
                        dt.sellPrice1,
                        dt.sellAmount1 != '' ? dt.sellAmount1 : '0',
                        true
                      ],
                      10: [
                        dt.buyPrice1,
                        dt.buyAmount1 != '' ? dt.buyAmount1 : '0',
                        false
                      ],
                      11: [
                        dt.buyPrice2,
                        dt.buyAmount2 != '' ? dt.buyAmount2 : '0',
                        false
                      ],
                      12: [
                        dt.buyPrice3,
                        dt.buyAmount3 != '' ? dt.buyAmount3 : '0',
                        false
                      ],
                      13: [
                        dt.buyPrice4,
                        dt.buyAmount4 != '' ? dt.buyAmount4 : '0',
                        false
                      ],
                      14: [
                        dt.buyPrice5,
                        dt.buyAmount5 != '' ? dt.buyAmount5 : '0',
                        false
                      ],
                      15: [
                        dt.buyPrice6,
                        dt.buyAmount6 != '' ? dt.buyAmount6 : '0',
                        false
                      ],
                      16: [
                        dt.buyPrice7,
                        dt.buyAmount7 != '' ? dt.buyAmount7 : '0',
                        false
                      ],
                      17: [
                        dt.buyPrice8,
                        dt.buyAmount8 != '' ? dt.buyAmount8 : '0',
                        false
                      ],
                      18: [
                        dt.buyPrice9,
                        dt.buyAmount9 != '' ? dt.buyAmount9 : '0',
                        false
                      ],
                      19: [
                        dt.buyPrice10,
                        dt.buyAmount10 != '' ? dt.buyAmount10 : '0',
                        false
                      ],
                    };
                    double maxAmount = -1;
                    for (var i = 0; i < hoga.length; i++) {
                      double tmp = double.parse(hoga[i]![1]);
                      if (maxAmount < tmp) {
                        maxAmount = tmp;
                      }
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        UpperPrice(
                          cur:
                              '시가   ${double.parse(dt.open).toStringAsFixed(3)}$sign',
                          min:
                              '저가   ${double.parse(dt.low).toStringAsFixed(3)}$sign',
                          max:
                              '고가   ${double.parse(dt.high).toStringAsFixed(3)}$sign',
                        ),
                        const SizedBox(height: 10),
                        LowerHoga(
                          curPrice: curPrice,
                          sign: sign!,
                          hoga: hoga,
                          maxAmount: maxAmount,
                        ),
                      ],
                    );
                  }
                  return const Text('');
                }),
          ],
        ),
      ),
    );
  }
}
