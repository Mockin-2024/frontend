import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class IndexChartWidget extends StatelessWidget {
  const IndexChartWidget({
    super.key,
    required this.name,
    required this.price,
    required this.rate,
    required this.chartData,
  });

  final String name, price, rate;
  final List<dynamic> chartData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Column(
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          Column(
            children: [
              Text(
                '$price  $rate',
                style: TextStyle(
                  color: rate[0] == '-' ? Colors.blue : Colors.red,
                  fontSize: 10,
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.33,
                  child: LineChart(
                    LineChartData(
                        gridData: const FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: List.generate(chartData.length, (idx) {
                              return FlSpot(
                                  idx.toDouble(), chartData[idx].last);
                            }),
                            color: Colors.red,
                            dotData: const FlDotData(show: false),
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
