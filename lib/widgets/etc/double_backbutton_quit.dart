import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DoubleBackbuttonQuit extends StatelessWidget {
  final Widget w;
  const DoubleBackbuttonQuit({
    super.key,
    required this.w,
  });

  @override
  Widget build(BuildContext context) {
    DateTime? lastPressedAt;
    const Duration backPressDuration = Duration(seconds: 2);

    void showExitWarning(BuildContext context) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('한 번 더 뒤로가기를 누르면 종료됩니다.'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        final now = DateTime.now();

        if (lastPressedAt == null ||
            now.difference(lastPressedAt!) > backPressDuration) {
          lastPressedAt = now;
          showExitWarning(context);
          return;
        }
        SystemNavigator.pop();
      },
      child: w,
    );
  }
}
