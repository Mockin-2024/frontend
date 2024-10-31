// ignore_for_file: must_be_immutable

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
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          labelText: name,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
          enabled: isChecking,
        ),
        keyboardType: TextInputType.text,
        controller: tec,
      ),
    );
  }
}
