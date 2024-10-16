import 'package:flutter/material.dart';

class ExchangeProvider with ChangeNotifier {
  String _selectedTrade = '나스닥';

  String get selectedTrade => _selectedTrade;

  void selectTrade(String trade) {
    _selectedTrade = trade;
    notifyListeners();
  }
}
