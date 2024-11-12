import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mockin/api/basic_api.dart';
import 'package:mockin/models/chart_data.dart';
import 'package:mockin/stocks/stock_detail.dart';
import 'package:mockin/provider/exchange_trans.dart';
import 'package:mockin/dto/basic/stock_chart_dto.dart';

class MainChart extends StatelessWidget {
  final Map<String, List<dynamic>> bunbong = {
    '1일': ['5', 1],
    '1주': ['10', 2],
    '1달': ['1440', 1],
    '3달': ['720', 2],
    '1년': ['360', 4],
    '5년': ['180', 8],
  };

  MainChart({
    super.key,
    required this.widget,
    required this.seletedGap,
  });

  final StockDetail widget;
  final String seletedGap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.4,
      child: FutureBuilder(
        future: BasicApi.minutesChart(
          DTO: StockChartDTO(
            EXCD: widget.excd,
            SYMB: widget.stockSymb,
            NMIN: bunbong[seletedGap]![0],
            PINC: '1',
            NREC: '120',
          ),
          period: bunbong[seletedGap]![1],
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ChartData> dt = snapshot.data;
            // print(dt.length);
            // for (var d in dt) {
            //   print('>>> ${d.dt} ${d.last}');
            // }
            return LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index >= 0 && index < dt.length) {
                          final time = dt[index].dt;
                          return Text('${time.hour}:${time.minute}');
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(dt.length, (idx) {
                      return FlSpot(idx.toDouble(), dt[idx].last);
                    }),
                    isCurved: false,
                    color: Colors.red,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
                borderData: FlBorderData(show: false),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => Colors.black,
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      return touchedSpots.map((touchedSpot) {
                        final dateTime = dt[touchedSpot.x.toInt()].dt;
                        final price = touchedSpot.y;

                        return LineTooltipItem(
                          '${dateTime.year}.${dateTime.month}.${dateTime.day} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}\n$price${ExchangeTrans.signExchange[widget.excd]}',
                          const TextStyle(
                            color: Colors.white,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            );
          }
          return const Text('-');
        },
      ),
    );
  }
}
