import 'package:flutter/material.dart';
import 'package:mockin/search/search.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Search(),
          ),
        );
      },
      icon: const Icon(
        Icons.search_outlined,
        color: Colors.black,
        size: 40,
      ),
    );
  }
}
