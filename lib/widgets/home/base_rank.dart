import 'package:flutter/material.dart';
import 'package:mockin/exchange_transform/exchange_trans.dart';
import 'package:mockin/stocks/stock_detail.dart';
import 'package:mockin/storage/favorite_data.dart';

class BaseRank extends StatefulWidget {
  final String excd, stockName, stockSymb, stockPrice, stockRate;

  const BaseRank({
    super.key,
    required this.excd,
    required this.stockName,
    required this.stockSymb,
    required this.stockPrice,
    required this.stockRate,
  });

  @override
  State<BaseRank> createState() => _BaseRankState();
}

class _BaseRankState extends State<BaseRank> {
  void favoriteChange() async {
    var rst = await FavoriteData().favoriteChange(
        excd: widget.excd,
        symb: widget.stockSymb,
        addOrDelete: FavoriteData()
            .isFavorite(excd: widget.excd, symb: widget.stockSymb));
    if (rst) {
      //print('>>> ${widget.excd} ${widget.stockSymb} 성공');
    } else {
      //print('>>> ${widget.excd} ${widget.stockSymb} 실패');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StockDetail(
                  excd: widget.excd,
                  stockName: widget.stockName,
                  stockSymb: widget.stockSymb,
                ),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.stockName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Text(
                          '${widget.stockPrice}${ExchangeTrans.signExchange[widget.excd]}  ',
                          style: const TextStyle(color: Colors.black),
                        ),
                        Text(
                          '${widget.stockRate}%',
                          style: TextStyle(
                              color: widget.stockRate.contains('-')
                                  ? Colors.blue
                                  : Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  favoriteChange();
                },
                icon: const Icon(
                  Icons.favorite,
                ),
                color: FavoriteData()
                        .isFavorite(excd: widget.excd, symb: widget.stockSymb)
                    ? Colors.red
                    : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
