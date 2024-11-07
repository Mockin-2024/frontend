import 'package:flutter/material.dart';
import 'package:mockin/api/basic_api.dart';
import 'package:mockin/dto/basic/current_detailed_dto.dart';
import 'package:mockin/provider/exchange_trans.dart';
import 'package:mockin/stocks/stock_detail.dart';
import 'package:mockin/widgets/stock_detailed/more_info/info_box.dart';
import 'package:mockin/widgets/stock_detailed/more_info/line_bar.dart';
import 'package:mockin/widgets/text/content_text.dart';
import 'package:mockin/widgets/text/title_text.dart';

class MoreInfoTab extends StatelessWidget {
  const MoreInfoTab({
    super.key,
    required this.curPrice,
    required this.widget,
  });

  final double curPrice;
  final StockDetail widget;

  @override
  Widget build(BuildContext context) {
    var sign = ExchangeTrans.signExchange[widget.excd];
    return SingleChildScrollView(
      child: FutureBuilder(
          future: BasicApi.currentDetailed(
            DTO: CurrentDetailedDTO(
              EXCD: widget.excd,
              SYMB: widget.stockSymb,
            ),
          ),
          builder: (context, snapshot) {
            //  jd['high'], // 고가
            //  jd['low'], // 저가
            //  jd['h52p'], // 52주 최고가
            //  jd['l52p'], // 52주 최저가
            //  jd['perx'], // PER
            //  jd['pbrx'], // PBR
            //  jd['epsx'], // EPS
            //  jd['bpsx'], // BPS
            //  jd['shar'], // 상장주수
            //  jd['tomv'], // 시가총액
            //  jd['tvol'], // 거래량
            //  jd['tamt'], // 거래대금
            //  jd['t_rate'], // 당일환율
            if (snapshot.hasData) {
              var dd = snapshot.data!; // detailedData
              double progressDay = (curPrice - double.parse(dd[1])) /
                  (double.parse(dd[0]) - double.parse(dd[1]));
              progressDay = progressDay.clamp(0.0, 1.0);
              double progress52 = (curPrice - double.parse(dd[3])) /
                  (double.parse(dd[2]) - double.parse(dd[3]));
              progress52 = progress52.clamp(0.0, 1.0);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TitleText(tt: '시세'),
                  LineBar(
                      progressData: progressDay,
                      period: '오늘',
                      low: dd[1],
                      curPrice: curPrice.toString(),
                      high: dd[0],
                      sign: sign!),
                  const SizedBox(height: 10),
                  LineBar(
                      progressData: progress52,
                      period: '52주',
                      low: dd[3],
                      curPrice: curPrice.toString(),
                      high: dd[2],
                      sign: sign),
                  const SizedBox(height: 15),
                  const TitleText(tt: '투자지표'),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoBox(
                          category: '시가총액',
                          value: dd[9],
                          sign: sign,
                          isInt: true),
                      InfoBox(
                          category: '상장주수',
                          value: dd[8],
                          sign: sign,
                          isInt: true),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoBox(
                          category: '거래량',
                          value: dd[10],
                          sign: '주',
                          isInt: true),
                      InfoBox(
                          category: '거래대금',
                          value: dd[11],
                          sign: sign,
                          isInt: true),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoBox(
                          category: 'PER',
                          value: dd[4],
                          sign: '배',
                          isInt: false),
                      InfoBox(
                          category: 'PBR',
                          value: dd[5],
                          sign: '배',
                          isInt: false),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoBox(
                          category: 'EPS',
                          value: dd[6],
                          sign: sign,
                          isInt: false),
                      InfoBox(
                          category: 'BPS',
                          value: dd[7],
                          sign: sign,
                          isInt: false),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const TitleText(tt: '환율'),
                  ContentText(tt: '${dd[12]}원'),
                ],
              );
            }
            return const Text('');
          }),
    );
  }
}
