import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _trade = ['나스닥', '뉴욕', '홍콩', '아멕스', '상해', '심천', '호치민', '하노이', '도쿄'];

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
