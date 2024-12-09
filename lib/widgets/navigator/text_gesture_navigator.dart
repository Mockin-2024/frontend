import 'package:flutter/material.dart';

class TextGestureNavigator extends StatelessWidget {
  final Widget movePage;
  final String name;

  const TextGestureNavigator({
    super.key,
    required this.movePage,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => movePage,
          ),
        );
      },
      child: Text(
        name,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodySmall!.color,
          fontSize: 18,
        ),
      ),
    );
  }
}
