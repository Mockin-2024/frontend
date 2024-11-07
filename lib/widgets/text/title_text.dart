import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.tt,
  });
  final String tt;
  @override
  Widget build(BuildContext context) {
    return Text(
      tt,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
    );
  }
}
