import 'package:flutter/material.dart';

class Alert {
  static void showAlert(
      BuildContext context, String behavior, String failSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            '$behavior $failSuccess',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
