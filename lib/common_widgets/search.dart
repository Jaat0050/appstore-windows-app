import 'package:flutter/material.dart';
import 'package:neurostore/view/search_result_screen.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width < 600 ? 120 : 230,
      height: 40,
      margin: const EdgeInsets.only(top: 12, bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade700)),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        const Icon(
          Icons.search,
          color: Colors.grey,
        ),
        const SizedBox(width: 10),
        Expanded(
            child: GestureDetector(
          onTap: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const SearchResultScreen(),
              ),
            );
          },
          child: TextField(
            enabled: false,
            style: TextStyle(color: Colors.grey),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width < 600 ? 13 : 18),
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.grey)),
          ),
        ))
      ]),
    );
  }
}
