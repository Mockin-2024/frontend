import 'package:flutter/material.dart';

class StockHowInvest extends StatefulWidget {
  const StockHowInvest({super.key});

  @override
  State<StockHowInvest> createState() => _StockCanInvestState();
}

class _StockCanInvestState extends State<StockHowInvest> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
