import 'package:flutter/material.dart';
import 'package:neurostore/common_widgets/common_bottomSheet.dart';
import 'package:neurostore/common_widgets/profile_icon.dart';
import 'package:neurostore/common_widgets/search.dart';
import 'package:neurostore/utils/constants.dart';
import 'package:neurostore/view/product_details.dart';

class FullSectionPage extends StatefulWidget {
  final String title;
  final List<dynamic> items;
  final Key? key;

  const FullSectionPage({required this.title, required this.items, this.key});

  @override
  State<FullSectionPage> createState() => _FullSectionPageState();
}

class _FullSectionPageState extends State<FullSectionPage> {
  final ScrollController _scrollController = ScrollController();
  bool showSizedBox = false;
  int isHoveredIndex = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkScrollPosition();
      _scrollController.addListener(_checkScrollPosition);
    });
  }

  void _checkScrollPosition() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        showSizedBox = true;
      });
    } else {
      if (_scrollController.position.maxScrollExtent <
          _scrollController.position.extentBefore) {
        setState(() {
          showSizedBox = true;
        });
      } else {
        setState(() {
          showSizedBox = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_checkScrollPosition);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: const [SearchWidget(), ProfileIconInAppBar()],
      ),
      body: GridView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width < 600 ? 10 : 30,
            right: MediaQuery.of(context).size.width < 600 ? 10 : 30,
            top: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width < 600 ? 1 : 3,
            mainAxisExtent: MediaQuery.of(context).size.width < 600 ? 120 : 150,
            mainAxisSpacing: 20,
            crossAxisSpacing: 30),
        itemCount: widget.items.length,
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
                          title: widget.items[index].name,
                          img: widget.items[index].imageUrl,
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
                              child: Image.asset(widget.items[index].imageUrl,
                                  width: MediaQuery.of(context).size.width < 600
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
                              Text(widget.items[index].name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Text(widget.items[index].category,
                                  style: const TextStyle(
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
      bottomNavigationBar: showSizedBox ? bottomSheetBuilder() : null,
    );
  }
}
