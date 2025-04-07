import 'package:flutter/material.dart';
import 'package:neurostore/utils/constants.dart';
import 'package:neurostore/view/homescreen.dart';
import 'package:neurostore/view/product_details.dart';

class SearchResultScreen extends StatefulWidget {
  final Key? key;

  const SearchResultScreen({this.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  TextEditingController _searchController = TextEditingController();

  List totalList = [...apps, ...games, ...entertainments];
  List searchedItems = [];
  int isHoveredIndex = -1;

  @override
  void initState() {
    super.initState();
    searchedItems = totalList;
  }

  void _filterItems(String query) {
    setState(
      () {
        if (query.isNotEmpty) {
          searchedItems = totalList
              .where((item) =>
                  item.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
        } else {
          searchedItems = totalList;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
      appBar: AppBar(
        title: const Text(
          'Find',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [
          Container(
            width: MediaQuery.of(context).size.width < 600 ? 150 : 230,
            height: 40,
            margin: const EdgeInsets.only(right: 20, top: 12, bottom: 12),
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
                  child: TextField(
                autofocus: true,
                controller: _searchController,
                onChanged: (value) {
                  _filterItems(value);
                },
                style: TextStyle(
                    color: searchedItems.isEmpty ? Colors.red : Colors.white),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        bottom:
                            MediaQuery.of(context).size.width < 600 ? 13 : 18),
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.grey)),
              ))
            ]),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width < 600 ? 10 : 30,
            right: MediaQuery.of(context).size.width < 600 ? 10 : 30,
            top: 20),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width < 600 ? 1 : 3,
              mainAxisExtent:
                  MediaQuery.of(context).size.width < 600 ? 120 : 150,
              mainAxisSpacing: 20,
              crossAxisSpacing: 30),
          itemCount: searchedItems.length,
          itemBuilder: (BuildContext context, int index) {
            return MouseRegion(
              onEnter: (_) {
                setState(() {
                  isHoveredIndex = index;
                });
              },
              onExit: (_) {
                setState(() {
                  isHoveredIndex = -1;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: Transform.scale(
                  scale: isHoveredIndex == index ? 1.05 : 1.0,
                  child: InkWell(
                    hoverColor: Colors.grey,
                    overlayColor: const MaterialStatePropertyAll(Colors.grey),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetails(
                            title: searchedItems[index].name,
                            img: searchedItems[index].imageUrl,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: darkGrey,
                          border: Border.all(
                              color: Colors.grey.shade600,
                              width: 1.0,
                              style: BorderStyle.solid)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                                margin: const EdgeInsets.all(0),
                                elevation: 6,
                                child: Image.asset(
                                    searchedItems[index].imageUrl,
                                    width:
                                        MediaQuery.of(context).size.width < 600
                                            ? 120
                                            : 150,
                                    height:
                                        MediaQuery.of(context).size.width < 600
                                            ? 120
                                            : 140,
                                    fit: BoxFit.cover)),
                            const SizedBox(width: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(searchedItems[index].name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                const Text('genre',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
