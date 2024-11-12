import 'package:flutter/material.dart';
import 'package:mockin/widgets/text/category_text.dart';
import 'package:mockin/widgets/text/content_text.dart';

class InfoBox extends StatelessWidget {
  const InfoBox({
    super.key,
    required this.category,
    required this.value,
    required this.sign,
    required this.isInt,
  });

  final String category, value, sign;
  final bool isInt;

  String smaller(String s) {
    if (s.length > 12) {
      return '${s.substring(0, s.length - 12)}조 ';
    } else if (s.length > 8) {
      return '${s.substring(0, s.length - 8)}억 ';
    } else if (s.length > 4) {
      return '${s.substring(0, s.length - 4)}만 ';
    }
    return s;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CategoryText(tt: category),
          const SizedBox(height: 20),
          ContentText(tt: isInt ? '${smaller(value)}$sign' : '$value$sign'),
        ],
      ),
    );
  }
}
