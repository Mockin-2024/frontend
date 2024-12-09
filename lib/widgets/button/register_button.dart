import 'package:flutter/material.dart';
import 'package:mockin/widgets/etc/alert.dart';

class RegisterButton extends StatelessWidget {
  final String name, first;
  final Function onPressed;

  const RegisterButton({
    super.key,
    required this.name,
    required this.first,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          if (await onPressed()) {
            if (!context.mounted) return;
            Alert.showAlert(context, first, '성공!');
          } else {
            if (!context.mounted) return;
            Alert.showAlert(context, first, '실패');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
        ),
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
