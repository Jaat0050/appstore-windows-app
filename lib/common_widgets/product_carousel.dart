import 'package:flutter/material.dart';
import 'package:neurostore/model/app_model.dart';
import 'package:neurostore/view/product_details.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductCarousel extends StatefulWidget {
  final String title;
  final List<dynamic> items;
  final VoidCallback onTap;
  final Key? key;
  bool isSlider;

  ProductCarousel({
    required this.title,
    required this.items,
    required this.onTap,
    this.key,
    this.isSlider = false,
  });

  @override
  State<ProductCarousel> createState() => _ProductCarouselState();
}

class _ProductCarouselState extends State<ProductCarousel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      key: widget.key,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: 16.0, right: 16, bottom: widget.isSlider ? 8 : 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: widget.isSlider ? 10 : 0,
                    bottom: 10,
                    left: 10,
                    right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' ${widget.title}',
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 1.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: widget.onTap,
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (widget.isSlider) const Divider(color: Colors.white, height: 1),
        SizedBox(
          height: widget.isSlider ? 330.0 : 190,
          child: widget.isSlider
              ? Container(
                  color: Colors.black,
                  padding: EdgeInsets.only(
                      top: widget.isSlider ? 20 : 0, bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                        enlargeCenterPage: true,
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: false,
                        enableInfiniteScroll: true,
                        aspectRatio: 3 / 2,
                        viewportFraction: MediaQuery.of(context).size.width <
                                600
                            ? 0.8
                            : MediaQuery.of(context).size.width < 800
                                ? 0.7
                                : MediaQuery.of(context).size.width < 1000
                                    ? 0.6
                                    : MediaQuery.of(context).size.width < 1200
                                        ? 0.5
                                        : MediaQuery.of(context).size.width <
                                                1400
                                            ? 0.4
                                            : 0.3,
                        pageSnapping: true),
                    itemCount: widget.items.length,
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return isSliderItemTab(context, index);
                    },
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.items.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return itemBuilder(context, index);
                  },
                ),
        ),
      ],
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    bool isHovered = false;

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: Transform.scale(
            scale: isHovered ? 1.05 : 1.0,
            child: GestureDetector(
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
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 10, bottom: 10),
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    width: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10.0)),
                          child: Image.asset(
                            widget.items[index].imageUrl,
                            height: 130.0,
                            width: 150.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Divider(height: 1),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            widget.items[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        // if (widget.items[index] is App)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            widget.items[index].category,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget isSliderItemTab(BuildContext context, int index) {
    return GestureDetector(
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
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 0),
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: 600.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    widget.items[index].imageUrl,
                    height: 270.0,
                    width: 600.0,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 100.0,
                    width: 600.0,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0)),
                      color: Colors.black54,
                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.width < 600 ? 3 : 10,
                  left: 12,
                  right: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.items[index].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        widget.items[index].category,
                        style: TextStyle(
                          color: Colors.grey[400],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 3),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'Introducing the Multi-Purpose Utility Tool: your all-in-one solution for any task. Crafted for durability and convenience...',
                              style: TextStyle(color: Colors.grey[300]),
                            ),
                            const TextSpan(
                              text: ' see more',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
