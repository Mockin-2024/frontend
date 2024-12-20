import 'package:flutter/material.dart';
import 'package:mockin/widgets/text/small_text.dart';

class UpperPrice extends StatelessWidget {
  final String cur, min, max;

  const UpperPrice({
    super.key,
    required this.cur,
    required this.min,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SmallText(tt: cur),
        SmallText(tt: min),
        SmallText(tt: max),
      ],
    );
  }
}
