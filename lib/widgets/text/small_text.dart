import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  const SmallText({
    super.key,
    required this.tt,
  });

  final String tt;

  @override
  Widget build(BuildContext context) {
    return Text(
      tt,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 10,
      ),
    );
  }
}
