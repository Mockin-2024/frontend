import 'package:flutter/material.dart';
import 'package:mockin/api/basic_api.dart';
import 'package:mockin/api/trade_api.dart';
import 'package:mockin/dto/basic/current_price_dto.dart';
import 'package:mockin/dto/basic/term_dto.dart';
import 'package:mockin/dto/trading/balance_dto.dart';
import 'package:mockin/provider/exchange_trans.dart';
import 'package:mockin/stocks/detailed/chart_tab.dart';
import 'package:mockin/stocks/detailed/hoga_tab.dart';
import 'package:mockin/stocks/detailed/more_info_tab.dart';
import 'package:mockin/stocks/detailed/my_stock_tab.dart';
import 'package:mockin/widgets/buy_sell_button.dart';

class StockDetail extends StatefulWidget {
  final String excd, stockName, stockSymb;

  const StockDetail({
    super.key,
    required this.excd,
    required this.stockName,
    required this.stockSymb,
  });

  @override
  State<StockDetail> createState() => _StockDetailState();
}

class _StockDetailState extends State<StockDetail> {
  double price = 0.0, pastPrice = 0.0, diff = 0.0, rate = 0.0;
  String canBuy = '-', seletedGap = '1일';
  bool stockHave = false;

  final Map<String, List<dynamic>> gapGUBN = {
    '1일': ['0', 1],
    '1주': ['1', 1],
    '1달': ['2', 1],
    '3달': ['2', 3],
    '1년': ['2', 12],
    '5년': ['2', 60],
  }; // 일,주,달 구분과 index

  @override
  void initState() {
    super.initState();
    fetchingData();
  }

  void fetchingData() async {
    List<String> rst = await BasicApi.currentPrice(
      DTO: CurrentPriceDTO(
        excd: widget.excd,
        symb: widget.stockSymb,
      ),
    );
    price = double.parse(rst[0]);
    pastPrice = double.parse(rst[1]);
    diff = price - pastPrice;
    rate = diff / pastPrice * 100;
    canBuy = rst[2];

    stockHave = await TradeApi.balanceDoIHave(
      DTO: BalanceDTO(
        overseasExchangeCode: ExchangeTrans.orderTrade[widget.excd]!,
        transactionCurrencyCode:
            ExchangeTrans.transactionCurrency[widget.excd]!,
      ),
      stockName: widget.stockName,
    );
    setState(() {});
  }

  void _onDateSeleted(String date) async {
    // gap인 날만큼의 종가를 들고와서 현재
    // price와 계산 후 diff, rate를 계산
    seletedGap = date;
    pastPrice = double.parse(
      await BasicApi.termPrice(
        DTO: TermDTO(
          EXCD: widget.excd,
          SYMB: widget.stockSymb,
          GUBN: gapGUBN[seletedGap]![0],
        ),
        idx: gapGUBN[seletedGap]![1],
      ),
    );
    diff = price - pastPrice;
    rate = diff / pastPrice * 100;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var sign = ExchangeTrans.signExchange[widget.excd];
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(110.0),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.stockName} (${widget.stockSymb})',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '$price${ExchangeTrans.signExchange[widget.excd]}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '$seletedGap 전 보다 ',
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              diff > 0
                                  ? '+${diff.toStringAsFixed(2)}$sign (${rate.toStringAsFixed(2)}%)'
                                  : '${diff.toStringAsFixed(2)}$sign (${rate.toStringAsFixed(2)}%)',
                              style: TextStyle(
                                color: diff > 0 ? Colors.red : Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          canBuy,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    TabBar(
                        labelColor: Colors.black,
                        dividerColor: Colors.white,
                        indicatorColor: Colors.white,
                        unselectedLabelColor: Colors.black.withOpacity(0.5),
                        tabs: const [
                          Tab(text: '차트'),
                          Tab(text: '호가'),
                          Tab(text: '내 주식'),
                          Tab(text: '종목정보'),
                        ]),
                  ],
                ),
              ),
            ]),
          ),
        ),
        body: TabBarView(children: [
          ChartTab(widget: widget, onDateSelected: _onDateSeleted),
          const HogaTab(),
          MyStockTab(symb: widget.stockSymb),
          MoreInfoTab(
              curPrice: price, excd: widget.excd, symb: widget.stockSymb),
        ]),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              stockHave
                  ? BuySellButton(
                      widget: widget,
                      buySell: '판매',
                      bs: false,
                      have: true,
                    )
                  : BuySellButton(
                      widget: widget,
                      buySell: '판매',
                      bs: false,
                      have: false,
                    ),
              BuySellButton(
                widget: widget,
                buySell: '구매',
                bs: true,
                have: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
