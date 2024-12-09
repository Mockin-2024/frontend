import 'package:flutter/material.dart';
import 'package:mockin/widgets/text/content_text.dart';

class TextGestureNavigatorReplacement extends StatelessWidget {
  final Widget movePage;
  final String name;

  const TextGestureNavigatorReplacement({
    super.key,
    required this.movePage,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Future.delayed(Duration.zero, () {
          if (!context.mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => movePage,
            ),
          );
        });
      },
      child: ContentText(tt: name),
    );
  }
}
