import 'package:flutter/material.dart';
import 'package:mockin/api/basic_api.dart';
import 'package:mockin/api/trade_api.dart';
import 'package:mockin/dto/basic/current_price_dto.dart';
import 'package:mockin/dto/basic/stock_chart_dto.dart';
import 'package:mockin/dto/basic/term_dto.dart';
import 'package:mockin/dto/trading/balance_dto.dart';
import 'package:mockin/models/chart_data.dart';
import 'package:mockin/provider/exchange_trans.dart';
import 'package:mockin/stocks/buy_or_sell.dart';
import 'package:fl_chart/fl_chart.dart';
// import 'package:mockin/widgets/news.dart';

class StockDetail extends StatefulWidget {
  final String excd, stockName, stockSymb, stockPrice, stockRate;

  const StockDetail({
    super.key,
    required this.excd,
    required this.stockName,
    required this.stockSymb,
    required this.stockPrice,
    required this.stockRate,
  });

  @override
  State<StockDetail> createState() => _StockDetailState();
}

class _StockDetailState extends State<StockDetail> {
  List<bool> isSelected = [true, false, false, false, false, false];
  final List<String> dayGap = ['1일', '1주', '1달', '3달', '1년', '5년'];

  final Map<String, List<dynamic>> gapGUBN = {
    '1일': ['0', 1],
    '1주': ['1', 1],
    '1달': ['2', 1],
    '3달': ['2', 3],
    '1년': ['2', 12],
    '5년': ['2', 60],
  }; // 일,주,달 구분과 index

  final Map<String, List<dynamic>> bunbong = {
    '1일': ['5', 1],
    '1주': ['10', 2],
    '1달': ['1440', 1],
    '3달': ['1440', 3],
    '1년': ['1440', 12],
    '5년': ['1440', 60],
  }; // 일자에 따른 분봉 갭, 반복 횟수

  @override
  Widget build(BuildContext context) {
    var seletedGap = dayGap[isSelected.indexOf(true)];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 0, 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                      '${widget.stockName} (${widget.stockSymb})',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.stockPrice}${ExchangeTrans.signExchange[widget.excd]}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        FutureBuilder(
                          future: BasicApi.termPrice(
                            DTO: TermDTO(
                              EXCD: widget.excd,
                              SYMB: widget.stockSymb,
                              GUBN: gapGUBN[seletedGap]![0],
                            ),
                            idx: gapGUBN[seletedGap]![1],
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              // gap인 날만큼의 종가를 들고와서 현재
                              // price와 계산 후 diff, rate를 계산
                              var pastPrice = snapshot.data;
                              var diff = double.parse(widget.stockPrice) -
                                  double.parse(pastPrice);
                              var rate = diff / double.parse(pastPrice) * 100;
                              var sign =
                                  ExchangeTrans.signExchange[widget.excd];
                              return Row(
                                children: [
                                  Text(
                                    '$seletedGap 전 보다 ',
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    diff > 0
                                        ? '+${diff.toStringAsFixed(1)}$sign (${rate.toStringAsFixed(1)}%)'
                                        : '${diff.toStringAsFixed(1)}$sign (${rate.toStringAsFixed(1)}%)',
                                    style: TextStyle(
                                      color:
                                          diff > 0 ? Colors.red : Colors.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const Text(' ');
                            }
                          },
                        ),
                      ],
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '차트',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      FutureBuilder(
                          future: BasicApi.currentPrice(
                            DTO: CurrentPriceDTO(
                              excd: widget.excd,
                              symb: widget.stockSymb,
                            ),
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                '현재 상태 / ${snapshot.data}',
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              );
                            } else {
                              return const Text('');
                            }
                          }),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
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
                              isCurved: true,
                              color: Colors.red,
                              dotData: const FlDotData(show: false),
                              belowBarData: BarAreaData(show: false),
                            ),
                          ],
                          borderData: FlBorderData(show: false),
                          lineTouchData: LineTouchData(
                            touchTooltipData: LineTouchTooltipData(
                              getTooltipColor: (touchedSpot) => Colors.black,
                              getTooltipItems:
                                  (List<LineBarSpot> touchedSpots) {
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
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ToggleButtons(
                  isSelected: isSelected,
                  renderBorder: false,
                  color: Colors.black.withOpacity(0.4),
                  selectedColor: Colors.black,
                  fillColor: Colors.white,
                  onPressed: (int idx) {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = i == idx;
                      }
                    });
                  },
                  children: dayGap.map((gap) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: Text(gap),
                    );
                  }).toList(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FutureBuilder(
                  future: TradeApi.balanceDoIHave(
                    DTO: BalanceDTO(
                      overseasExchangeCode:
                          ExchangeTrans.orderTrade[widget.excd]!,
                      transactionCurrencyCode:
                          ExchangeTrans.transactionCurrency[widget.excd]!,
                    ),
                    stockName: widget.stockName,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == true) {
                        return BuySellButton(
                          widget: widget,
                          buySell: '판매',
                          bs: false,
                          have: true,
                        );
                      }
                    }
                    return BuySellButton(
                      widget: widget,
                      buySell: '판매',
                      bs: false,
                      have: false,
                    );
                  },
                ),
                BuySellButton(
                    widget: widget, buySell: '구매', bs: true, have: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BuySellButton extends StatelessWidget {
  const BuySellButton({
    super.key,
    required this.widget,
    required this.buySell,
    required this.bs,
    required this.have,
  });

  final StockDetail widget;
  final String buySell;
  final bool bs, have;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: have
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BuyOrSell(
                    excd: widget.excd,
                    stockName: widget.stockName,
                    stockSymb: widget.stockSymb,
                    stockPrice: widget.stockPrice,
                    stockRate: widget.stockRate,
                    buy: bs,
                  ),
                ),
              );
            }
          : null,
      child: Text(
        buySell,
        style: TextStyle(
          color: have ? Colors.black : Colors.black.withOpacity(0.5),
        ),
      ),
    );
  }
}
