import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String name;
  final TextEditingController tec;

  const TextInput({
    super.key,
    required this.name,
    required this.tec,
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
        ),
        keyboardType: TextInputType.text,
        controller: tec,
      ),
    );
  }
}
