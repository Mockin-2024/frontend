import 'package:flutter/material.dart';
import 'package:mockin/api/basic_api.dart';
import 'package:mockin/dto/basic/condition_search_dto.dart';
import 'package:mockin/models/basic_stock_model.dart';
import 'package:mockin/provider/exchange_trans.dart';
import 'package:mockin/widgets/base_rank.dart';
import 'package:mockin/widgets/exchange.dart';
import 'package:mockin/widgets/text_input.dart';
import 'package:provider/provider.dart';
import '../provider/exchange_provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isCurpriceChecked = false; // 현재가
  bool isUpdownrateChecked = false; // 등락율
  bool isMarketcapitalChecked = false; // 시가총액
  bool isTradeamountChecked = false; // 거래대금
  bool isTradevolumeChecked = false; // 거래량

  String curpriceMin = '';
  String curpriceMax = '';
  String updownrateMin = '';
  String updownrateMax = '';
  String marketcapitalMin = '';
  String marketcapitalMax = '';
  String tradeamountMin = '';
  String tradeamountMax = '';
  String tradevolumeMin = '';
  String tradevolumeMax = '';

  var searchWord = TextEditingController(); // 검색어

  // 모달 시트 띄우기
  void openFilterModal() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FilterBottomSheet(
            isCurpriceChecked: isCurpriceChecked,
            isUpdownrateChecked: isUpdownrateChecked,
            isMarketcapitalChecked: isMarketcapitalChecked,
            isTradeamountChecked: isTradeamountChecked,
            isTradevolumeChecked: isTradevolumeChecked,
            curpriceMin: curpriceMin,
            curpriceMax: curpriceMax,
            updownrateMin: updownrateMin,
            updownrateMax: updownrateMax,
            marketcapitalMin: marketcapitalMin,
            marketcapitalMax: marketcapitalMax,
            tradeamountMin: tradeamountMin,
            tradeamountMax: tradeamountMax,
            tradevolumeMin: tradevolumeMin,
            tradevolumeMax: tradevolumeMax,
          );
        });

    // 모달에서 반환된 값을 저장
    if (result != null) {
      isCurpriceChecked = result['isCurpriceChecked'];
      isUpdownrateChecked = result['isUpdownrateChecked'];
      isMarketcapitalChecked = result['isMarketcapitalChecked'];
      isTradeamountChecked = result['isTradeamountChecked'];
      isTradevolumeChecked = result['isTradevolumeChecked'];
      curpriceMin = result['curpriceMin'];
      curpriceMax = result['curpriceMax'];
      updownrateMin = result['updownrateMin'];
      updownrateMax = result['updownrateMax'];
      marketcapitalMin = result['marketcapitalMin'];
      marketcapitalMax = result['marketcapitalMax'];
      tradeamountMin = result['tradeamountMin'];
      tradeamountMax = result['tradeamountMax'];
      tradevolumeMin = result['tradevolumeMin'];
      tradevolumeMax = result['tradevolumeMax'];
      setState(() {});
    }
  }

  List<BasicStockModel> filtering(List<BasicStockModel> basics) {
    List<BasicStockModel> meetConditions = [];
    for (var basic in basics) {
      if (isCurpriceChecked) {
        if (curpriceMin != '' &&
            double.parse(basic.last) < double.parse(curpriceMin)) {
          continue;
        }
        if (curpriceMax != '' &&
            double.parse(basic.last) > double.parse(curpriceMax)) {
          continue;
        }
      }
      if (isUpdownrateChecked) {
        if (updownrateMin != '' &&
            double.parse(basic.rate) < double.parse(updownrateMin)) {
          continue;
        }
        if (updownrateMax != '' &&
            double.parse(basic.rate) > double.parse(updownrateMax)) {
          continue;
        }
      }
      if (isMarketcapitalChecked) {
        if (marketcapitalMin != '' &&
            double.parse(basic.valx) < double.parse(marketcapitalMin)) {
          continue;
        }
        if (marketcapitalMax != '' &&
            double.parse(basic.valx) > double.parse(marketcapitalMax)) {
          continue;
        }
      }
      if (isTradeamountChecked) {
        if (tradeamountMin != '' &&
            double.parse(basic.avol) < double.parse(tradeamountMin)) {
          continue;
        }
        if (tradeamountMax != '' &&
            double.parse(basic.avol) > double.parse(tradeamountMax)) {
          continue;
        }
      }
      if (isTradevolumeChecked) {
        if (tradevolumeMin != '' &&
            double.parse(basic.tvol) < double.parse(tradevolumeMin)) {
          continue;
        }
        if (tradevolumeMax != '' &&
            double.parse(basic.tvol) > double.parse(tradevolumeMax)) {
          continue;
        }
        if (searchWord.text.isNotEmpty) {
          if (!basic.name.contains(searchWord.text) &&
              !basic.symb.contains(searchWord.text)) {
            continue;
          }
        }
      }
      meetConditions.add(basic);
    }
    return meetConditions;
  }

  @override
  Widget build(BuildContext context) {
    var trade = Provider.of<ExchangeProvider>(context).selectedTrade;
    final Future<List<BasicStockModel>> fetching = BasicApi.conditionSearch(
      DTO: ConditionSearchDTO(
        EXCD: ExchangeTrans.trade[trade]!,
      ),
      opt: 3,
    );
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 25,
            ),
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: const Icon(Icons.search_rounded,
                        size: 35, color: Colors.black)),
                labelText: '검색어를 입력해주세요!',
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
              ),
              keyboardType: TextInputType.text,
              controller: searchWord,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Exchange(),
              IconButton(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                onPressed: openFilterModal,
                icon: const Icon(Icons.filter_alt, size: 35),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder(
                future: fetching,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<BasicStockModel> stocks = snapshot.data!;
                    stocks = filtering(stocks);
                    return ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: stocks.length,
                        itemBuilder: (context, index) {
                          return BaseRank(
                            excd: stocks[index].excd,
                            stockName: stocks[index].name,
                            stockSymb: stocks[index].symb,
                            stockPrice: '${double.parse(stocks[index].last)}',
                            stockRate: stocks[index].rate,
                          );
                        });
                  }
                  return const Text('');
                }),
          ),
        ],
      ),
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  final bool isCurpriceChecked; // 현재가
  final bool isUpdownrateChecked; // 등락율
  final bool isMarketcapitalChecked; // 시가총액
  final bool isTradeamountChecked; // 거래대금
  final bool isTradevolumeChecked; // 거래량

  final String curpriceMin;
  final String curpriceMax;
  final String updownrateMin;
  final String updownrateMax;
  final String marketcapitalMin;
  final String marketcapitalMax;
  final String tradeamountMin;
  final String tradeamountMax;
  final String tradevolumeMin;
  final String tradevolumeMax;

  const FilterBottomSheet({
    super.key,
    required this.isCurpriceChecked,
    required this.isUpdownrateChecked,
    required this.isMarketcapitalChecked,
    required this.isTradeamountChecked,
    required this.isTradevolumeChecked,
    required this.curpriceMin,
    required this.curpriceMax,
    required this.updownrateMin,
    required this.updownrateMax,
    required this.marketcapitalMin,
    required this.marketcapitalMax,
    required this.tradeamountMin,
    required this.tradeamountMax,
    required this.tradevolumeMin,
    required this.tradevolumeMax,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  bool? isCurpriceChecked; // 현재가
  bool? isUpdownrateChecked; // 등락율
  bool? isMarketcapitalChecked; // 시가총액
  bool? isTradeamountChecked; // 거래대금
  bool? isTradevolumeChecked; // 거래량

  TextEditingController curpriceMinController = TextEditingController();
  TextEditingController curpriceMaxController = TextEditingController();
  TextEditingController updownrateMinController = TextEditingController();
  TextEditingController updownrateMaxController = TextEditingController();
  TextEditingController marketcapitalMinController = TextEditingController();
  TextEditingController marketcapitalMaxController = TextEditingController();
  TextEditingController tradeamountMinController = TextEditingController();
  TextEditingController tradeamountMaxController = TextEditingController();
  TextEditingController tradevolumeMinController = TextEditingController();
  TextEditingController tradevolumeMaxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isCurpriceChecked = widget.isCurpriceChecked;
    isUpdownrateChecked = widget.isUpdownrateChecked;
    isMarketcapitalChecked = widget.isMarketcapitalChecked;
    isTradeamountChecked = widget.isTradeamountChecked;
    isTradevolumeChecked = widget.isTradevolumeChecked;

    curpriceMinController.text = widget.curpriceMin;
    curpriceMaxController.text = widget.curpriceMax;
    updownrateMinController.text = widget.updownrateMin;
    updownrateMaxController.text = widget.updownrateMax;
    marketcapitalMinController.text = widget.marketcapitalMin;
    marketcapitalMaxController.text = widget.marketcapitalMax;
    tradeamountMinController.text = widget.tradeamountMin;
    tradeamountMaxController.text = widget.tradeamountMax;
    tradevolumeMinController.text = widget.tradevolumeMin;
    tradevolumeMaxController.text = widget.tradevolumeMax;
  }

  @override
  void dispose() {
    curpriceMinController.dispose();
    curpriceMaxController.dispose();
    updownrateMinController.dispose();
    updownrateMaxController.dispose();
    marketcapitalMinController.dispose();
    marketcapitalMaxController.dispose();
    tradeamountMinController.dispose();
    tradeamountMaxController.dispose();
    tradevolumeMinController.dispose();
    tradevolumeMaxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '필터링 설정',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckboxListTile(
                title: const Text(
                  '현재가',
                  style: TextStyle(color: Colors.black),
                ),
                value: isCurpriceChecked,
                onChanged: (value) {
                  setState(() {
                    isCurpriceChecked = value;
                  });
                },
              ),
              if (isCurpriceChecked ?? false)
                Column(
                  children: [
                    TextInput(name: '최소 현재가', tec: curpriceMinController),
                    TextInput(name: '최대 현재가', tec: curpriceMaxController),
                  ],
                ),
              CheckboxListTile(
                title: const Text(
                  '등락율',
                  style: TextStyle(color: Colors.black),
                ),
                value: isUpdownrateChecked,
                onChanged: (value) {
                  setState(() {
                    isUpdownrateChecked = value;
                  });
                },
              ),
              if (isUpdownrateChecked ?? false)
                Column(
                  children: [
                    TextInput(name: '최소 등락율', tec: updownrateMinController),
                    TextInput(name: '최대 등락율', tec: updownrateMaxController),
                  ],
                ),
              CheckboxListTile(
                title: const Text(
                  '시가총액',
                  style: TextStyle(color: Colors.black),
                ),
                value: isMarketcapitalChecked,
                onChanged: (value) {
                  setState(() {
                    isMarketcapitalChecked = value;
                  });
                },
              ),
              if (isMarketcapitalChecked ?? false)
                Column(
                  children: [
                    TextInput(name: '최소 시가총액', tec: marketcapitalMinController),
                    TextInput(name: '최대 시가총액', tec: marketcapitalMaxController),
                  ],
                ),
              CheckboxListTile(
                title: const Text(
                  '거래대금',
                  style: TextStyle(color: Colors.black),
                ),
                value: isTradeamountChecked,
                onChanged: (value) {
                  setState(() {
                    isTradeamountChecked = value;
                  });
                },
              ),
              if (isTradeamountChecked ?? false)
                Column(
                  children: [
                    TextInput(name: '최소 거래대금', tec: tradeamountMinController),
                    TextInput(name: '최대 거래대금', tec: tradeamountMaxController),
                  ],
                ),
              CheckboxListTile(
                title: const Text(
                  '거래량',
                  style: TextStyle(color: Colors.black),
                ),
                value: isTradevolumeChecked,
                onChanged: (value) {
                  setState(() {
                    isTradevolumeChecked = value;
                  });
                },
              ),
              if (isTradevolumeChecked ?? false)
                Column(
                  children: [
                    TextInput(name: '최소 거래량', tec: tradevolumeMinController),
                    TextInput(name: '최대 거래량', tec: tradevolumeMaxController),
                  ],
                ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'isCurpriceChecked': isCurpriceChecked,
                      'isUpdownrateChecked': isUpdownrateChecked,
                      'isMarketcapitalChecked': isMarketcapitalChecked,
                      'isTradeamountChecked': isTradeamountChecked,
                      'isTradevolumeChecked': isTradevolumeChecked,
                      'curpriceMin': curpriceMinController.text,
                      'curpriceMax': curpriceMaxController.text,
                      'updownrateMin': updownrateMinController.text,
                      'updownrateMax': updownrateMaxController.text,
                      'marketcapitalMin': marketcapitalMinController.text,
                      'marketcapitalMax': marketcapitalMaxController.text,
                      'tradeamountMin': tradeamountMinController.text,
                      'tradeamountMax': tradeamountMaxController.text,
                      'tradevolumeMin': tradevolumeMinController.text,
                      'tradevolumeMax': tradevolumeMaxController.text,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    '적용',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
