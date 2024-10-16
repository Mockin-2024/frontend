import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OneLine extends StatelessWidget {
  OneLine({
    super.key,
    required this.A,
    required this.B,
    this.bIsNum = false,
  });

  final String A;
  final String B;
  bool bIsNum;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            A,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          B,
          style: TextStyle(
            color: bIsNum
                ? B.contains('+')
                    ? Colors.red
                    : Colors.blue
                : Colors.black,
          ),
        ),
      ],
    );
  }
}
