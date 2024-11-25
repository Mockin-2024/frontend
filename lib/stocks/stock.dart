import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mockin/api/basic_api.dart';
import 'package:mockin/dto/basic/index_chart_dto.dart';
import 'package:mockin/widgets/index_chart_widget.dart';
import 'package:mockin/widgets/search_button.dart';
import 'package:mockin/widgets/exchange.dart';
import 'package:mockin/widgets/news_widget.dart';
import 'package:mockin/provider/exchange_provider.dart';
import 'package:provider/provider.dart';
import 'package:mockin/widgets/rank_content.dart';

class Stock extends StatefulWidget {
  const Stock({super.key});

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  final _ranking = ['거래대금', '거래량', '시가총액', '급상승', '급하락'];
  var _selectedRank = '거래대금';
  final List<List<String>> _indexs = [
    ['N', 'NDX', '0', 'Y'], // 나스닥
    ['N', 'SPX', '0', 'Y'], // S&P 500
    ['N', '.DJI', '0', 'Y'], // 다우존스
    ['N', 'SHANG', '0', 'Y'], // 상해
    // ['N', 'CH#SZA', '0', 'Y'], // 심천
    // ['N', 'JP#NI225', '0', 'Y'], // 닛케이(일본)
    ['N', 'HSCE', '0', 'Y'], // 홍콩
    // ['N', 'VN#VNI', '0', 'Y'], // 호치민
    // ['N', 'HNXI', '0', 'Y'], // 하노이
    ['X', 'FX@KRWKFTC', '0', 'Y'], // 미국 환율
    ['X', 'FX@KRWJS', '0', 'Y'], // 일본 환율
    ['X', 'FX@CNY', '0', 'Y'], // 중국 환율
    ['X', 'FX@HKD', '0', 'Y'], // 홍콩 환율
    ['X', 'FX@VND', '0', 'Y'], // 베트남 환율
  ];
  final List<String> _names = [
    '나스닥',
    'S&P 500',
    '다우존스',
    '상해',
    // '심천',
    // '일본',
    '홍콩',
    // '호치민',
    // '하노이',
    '미국 환율',
    '일본 환율',
    '중국 환율',
    '홍콩 환율',
    '베트남 환율',
  ];
  late Future<List<dynamic>> indexChartDatas;

  Map<String, int> trans = {
    '거래대금': 1,
    '거래량': 2,
    '시가총액': 3,
    '급상승': 4,
    '급하락': 5,
  };

  @override
  void initState() {
    super.initState();
    indexChartDatas = getIndexData();
  }

  Future<List<dynamic>> getIndexData() async {
    List<List<dynamic>> tmp = [];
    for (var i = 0; i < _indexs.length; i++) {
      var indexData = await BasicApi.minutesIndexChart(
        DTO: IndexChartDTO(
          fidCondMrktDivCode: _indexs[i][0],
          fidInputIscd: _indexs[i][1],
          fidHourClsCode: _indexs[i][2],
          fidPwDataIncuYn: _indexs[i][3],
        ),
      );
      tmp.add([_names[i], indexData]);
    }
    return tmp;
  }

  @override
  Widget build(BuildContext context) {
    var trade = Provider.of<ExchangeProvider>(context).selectedTrade;
    DateTime? lastPressedAt;
    const Duration backPressDuration = Duration(seconds: 2);

    void showExitWarning(BuildContext context) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('한 번 더 뒤로가기를 누르면 종료됩니다.'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          print('>>> didPop 호출');
          return;
        }
        final now = DateTime.now();

        if (lastPressedAt == null ||
            now.difference(lastPressedAt!) > backPressDuration) {
          print('>>> $now');
          lastPressedAt = now;
          showExitWarning(context);
          return;
        }
        SystemNavigator.pop();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Mockin',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                    SearchButton(),
                  ],
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.16,
                  child: FutureBuilder(
                    future: indexChartDatas,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var chartDatas = snapshot.data!;
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: chartDatas.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return IndexChartWidget(
                                name: chartDatas[index][0],
                                price: double.parse(chartDatas[index][1][0])
                                    .toStringAsFixed(2),
                                rate: chartDatas[index][1][1][0] == '-'
                                    ? '${chartDatas[index][1][1]}%'
                                    : '+${chartDatas[index][1][1]}%',
                                chartData: chartDatas[index][1][2],
                              );
                            });
                      }
                      return const Text('');
                    },
                  )),
              Column(children: [
                const Exchange(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '실시간 차트',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall!.color,
                          fontSize: 18,
                        ),
                      ),
                      DropdownButton(
                          value: _selectedRank,
                          items: _ranking.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedRank = value!;
                            });
                          }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RankContent(trade: trade, opt: trans[_selectedRank]!),
              ]),
              Column(children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '최신 금융 뉴스',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall!.color,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const NewsWidget(),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
