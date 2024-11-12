import 'package:flutter/material.dart';

Container mainContainer(BuildContext context, Widget w) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    height: MediaQuery.of(context).size.height * 0.4,
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 173, 173, 173),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        color: Colors.black,
        width: 1.0,
      ),
    ),
    child: w,
  );
}
