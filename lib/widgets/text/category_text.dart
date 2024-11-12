import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {
  const CategoryText({
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
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
