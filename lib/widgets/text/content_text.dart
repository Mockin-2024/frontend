import 'package:flutter/material.dart';

class ContentText extends StatelessWidget {
  const ContentText({
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
        fontSize: 16,
      ),
    );
  }
}
