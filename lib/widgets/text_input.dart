import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String name;
  final TextEditingController tec;
  bool isChecking;

  TextInput({
    super.key,
    required this.name,
    required this.tec,
    this.isChecking = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
      child: TextField(
        key: Key(name),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: name,
          enabled: isChecking,
        ),
        keyboardType: TextInputType.text,
        controller: tec,
      ),
    );
  }
}
