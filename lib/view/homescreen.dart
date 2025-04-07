import 'package:flutter/material.dart';
import 'package:neurostore/common_widgets/common_bottomSheet.dart';
import 'package:neurostore/common_widgets/product_carousel.dart';
import 'package:neurostore/common_widgets/profile_icon.dart';
import 'package:neurostore/model/app_model.dart';
import 'package:neurostore/model/entertainment_model.dart';
import 'package:neurostore/model/game_model.dart';
import 'package:neurostore/common_widgets/search.dart';
import 'package:neurostore/view/viewall.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool showSizedBox = false;

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
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/neurostore_logo.png',
              height: 40,
            ),
            const SizedBox(width: 12),
            const Text(
              'NeuroStore',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        actions: const [SearchWidget(), ProfileIconInAppBar()],
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          ProductCarousel(
            isSlider: true,
            title: 'Spotlight',
            items: [...apps, ...games, ...entertainments],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullSectionPage(
                    title: 'Spotlight',
                    items: [...apps, ...games, ...entertainments],
                  ),
                ),
              );
            },
          ),
          const Divider(color: Colors.white, height: 1),
          const SizedBox(height: 10),
          ProductCarousel(
            title: 'Apps',
            items: apps,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullSectionPage(
                    title: 'Apps',
                    items: apps,
                  ),
                ),
              );
            },
          ),
          Divider(color: Colors.grey.shade600, height: 30),
          ProductCarousel(
            title: 'Games',
            items: games,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullSectionPage(
                    title: 'Games',
                    items: games,
                  ),
                ),
              );
            },
          ),
          Divider(color: Colors.grey.shade600, height: 30),
          ProductCarousel(
            title: 'Entertainment',
            items: entertainments,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullSectionPage(
                    title: 'Entertainment',
                    items: entertainments,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 70),
        ],
      ),
      bottomNavigationBar: showSizedBox ? bottomSheetBuilder() : null,
    );
  }
}

final List<App> apps = [
  App(
    key: UniqueKey(),
    name: 'Meditation Timer',
    category: 'Health & Fitness',
    imageUrl: 'assets/app1.png',
  ),
  App(
    key: UniqueKey(),
    name: 'Book Ticket',
    category: 'Lifestyle',
    imageUrl: 'assets/app2.png',
  ),
  App(
    key: UniqueKey(),
    name: 'Night Show',
    category: 'Booking',
    imageUrl: 'assets/app3.png',
  ),
  // Add more apps here
];

final List<Game> games = [
  Game(
    key: UniqueKey(),
    name: 'Sudoku Challenge',
    category: 'Puzzle',
    imageUrl: 'assets/game1.png',
  ),
  Game(
    key: UniqueKey(),
    name: 'Nintendo',
    category: 'Adventure',
    imageUrl: 'assets/game2.png',
  ),
  Game(
    key: UniqueKey(),
    name: 'Bike Racing',
    category: 'Racing',
    imageUrl: 'assets/game3.png',
  ),
  // Add more games here
];

final List<Entertainment> entertainments = [
  Entertainment(
    key: UniqueKey(),
    name: 'Relaxing Sounds',
    category: 'Nice',
    imageUrl: 'assets/entertainment1.png',
  ),
  Entertainment(
    key: UniqueKey(),
    name: 'FM Sounds',
    category: 'Studio',
    imageUrl: 'assets/entertainment2.png',
  ),
  Entertainment(
    key: UniqueKey(),
    name: 'SM Entertainment',
    category: 'Movies',
    imageUrl: 'assets/entertainment3.png',
  ),
  Entertainment(
    key: UniqueKey(),
    name: 'Pixel Studio',
    category: 'Gaming',
    imageUrl: 'assets/entertainment4.png',
  ),
  // Add more entertainment items here
];
