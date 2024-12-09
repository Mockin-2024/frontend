import 'package:flutter/material.dart';

class MockinText extends StatelessWidget {
  final String tt;
  const MockinText({
    super.key,
    required this.tt,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      tt,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 52,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
