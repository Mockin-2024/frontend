import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final String name;
  final TextEditingController tec;

  const PasswordInput({
    super.key,
    required this.name,
    required this.tec,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _notShowing = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
      child: TextField(
        key: Key(widget.name),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.name,
          suffixIcon: IconButton(
              icon: Icon(
                _notShowing ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _notShowing = !_notShowing;
                });
              }),
        ),
        keyboardType: TextInputType.text,
        controller: widget.tec,
        obscureText: _notShowing,
      ),
    );
  }
}
