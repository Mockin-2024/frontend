import 'package:flutter/material.dart';

class TitleTextNoBold extends StatelessWidget {
  final String tt;
  final Color color;
  const TitleTextNoBold({
    super.key,
    required this.tt,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      tt,
      style: TextStyle(
        color: color,
        fontSize: 24,
      ),
    );
  }
}
