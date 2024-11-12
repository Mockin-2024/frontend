import 'package:flutter/material.dart';
import 'package:mockin/stocks/stock_detail.dart';
import 'package:mockin/widgets/main_chart.dart';

class ChartTab extends StatefulWidget {
  const ChartTab({
    super.key,
    required this.widget,
    required this.onDateSelected,
  });

  final StockDetail widget;
  final Function(String) onDateSelected;

  @override
  State<ChartTab> createState() => _ChartTabState();
}

class _ChartTabState extends State<ChartTab> {
  List<bool> isSelected = [true, false, false, false, false, false];
  final List<String> dayGap = ['1일', '1주', '1달', '3달', '1년', '5년'];

  @override
  Widget build(BuildContext context) {
    var seletedGap = dayGap[isSelected.indexOf(true)];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: MainChart(widget: widget.widget, seletedGap: seletedGap),
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
                      widget.onDateSelected(seletedGap);
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
            const Center(
              child: Text(
                '최대 조회 기간은 1개월입니다.',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
