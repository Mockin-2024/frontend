import 'package:flutter/material.dart';

class BasicText extends StatelessWidget {
  final String tt;
  const BasicText({
    super.key,
    required this.tt,
  });

  @override
  Widget build(BuildContext context) {
    return Text(tt, style: const TextStyle(color: Colors.black));
  }
}
