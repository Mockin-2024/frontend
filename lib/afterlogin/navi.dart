import 'package:flutter/material.dart';
import 'package:mockin/property/personal_stock.dart';
import 'package:mockin/stocks/stock.dart';
import 'package:mockin/stocks/stock_how_invest.dart';

class Navi extends StatelessWidget {
  const Navi({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        body: const TabBarView(
          children: [
            StockHowInvest(),
            Stock(),
            PersonalStock(),
          ],
        ),
        bottomNavigationBar: TabBar(
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black.withOpacity(0.5),
          tabs: const [
            Tab(
              icon: Icon(
                Icons.info_outline,
                size: 40,
              ),
              text: 'info',
            ),
            Tab(
              icon: Icon(
                Icons.bar_chart_sharp,
                size: 40,
              ),
              text: 'home',
            ),
            Tab(
              icon: Icon(
                Icons.money,
                size: 40,
              ),
              text: 'money',
            ),
          ],
        ),
      ),
    );
  }
}
