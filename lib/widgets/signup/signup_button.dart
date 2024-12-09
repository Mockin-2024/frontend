import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  final Future<Null> Function()? signUpFunction;
  final String tt;

  const SignupButton({
    super.key,
    required this.tt,
    required this.signUpFunction,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: signUpFunction,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
      ),
      child: Text(
        tt,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
