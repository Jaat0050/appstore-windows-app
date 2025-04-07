import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:neurostore/common_widgets/common_bottomSheet.dart';
import 'package:neurostore/common_widgets/profile_icon.dart';
import 'package:neurostore/common_widgets/search.dart';
import 'package:neurostore/utils/constants.dart';

class ProductDetails extends StatefulWidget {
  String? img;
  String? title;

  ProductDetails({super.key, this.img, this.title});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final ScrollController _scrollController = ScrollController();
  bool showSizedBox = false;

  String img1 = 'assets/1.jpg';
  String img2 = 'assets/2.jpg';
  String img3 = 'assets/3.jpg';
  String img4 = 'assets/4.jpg';

  String mainImg = '';

  @override
  void initState() {
    super.initState();
    mainImg = widget.img!;
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
      if (_scrollController.position.maxScrollExtent <=
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
        title: const Text(
          ' Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: const [SearchWidget(), ProfileIconInAppBar()],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MediaQuery.of(context).size.width < 600
                ? imageSliderDetailsBuilder()
                : Padding(
                    padding: const EdgeInsets.only(
                        left: 18, right: 18, top: 38, bottom: 100),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // runSpacing: 40,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 4),
                                  borderRadius: BorderRadius.circular(12)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  mainImg,
                                  height: 400.0,
                                  width: 650.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 40),
                            Container(
                              height: 400,
                              width: 180,
                              color: darkGrey,
                              padding: const EdgeInsets.all(10),
                              child: CarouselSlider.builder(
                                options: CarouselOptions(
                                    scrollDirection: Axis.vertical,
                                    enlargeStrategy:
                                        CenterPageEnlargeStrategy.zoom,
                                    enlargeCenterPage: true,
                                    scrollPhysics:
                                        const BouncingScrollPhysics(),
                                    autoPlay: false,
                                    enableInfiniteScroll: true,
                                    initialPage: 5,
                                    viewportFraction: 0.3,
                                    pageSnapping: true),
                                itemCount: 5,
                                itemBuilder: (BuildContext context, int index,
                                    int realIndex) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: isSliderItemTab(context, index),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 40),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 320,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: darkGrey,
                                      border: Border.all(
                                          color: Colors.grey.shade600,
                                          width: 1.0,
                                          style: BorderStyle.solid)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(' App Details',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white70,
                                              fontWeight: FontWeight.bold)),
                                      Divider(
                                          color: Colors.grey.shade600,
                                          height: 1),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  'Release Date - 17th May,2024',
                                                  style: TextStyle(
                                                      height: 2,
                                                      fontSize: 18,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                              Text('Size - 5 MB',
                                                  style: TextStyle(
                                                      height: 2,
                                                      fontSize: 18,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                              Text('Version - V02',
                                                  style: TextStyle(
                                                      height: 2,
                                                      fontSize: 18,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width: 320,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: darkGrey,
                                      border: Border.all(
                                          color: Colors.grey.shade600,
                                          width: 1.0,
                                          style: BorderStyle.solid)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(' Requirements',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white70,
                                              fontWeight: FontWeight.bold)),
                                      Divider(
                                          color: Colors.grey.shade600,
                                          height: 1),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 20),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Requirement 1',
                                                  style: TextStyle(
                                                      height: 2,
                                                      fontSize: 18,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                              Text('Requirement 2',
                                                  style: TextStyle(
                                                      height: 2,
                                                      fontSize: 18,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                              Text('Requirement 3',
                                                  style: TextStyle(
                                                      height: 2,
                                                      fontSize: 18,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                            ]),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
            Container(
              color: darkGrey,
              margin: EdgeInsets.only(
                  left: 18,
                  right: 18,
                  bottom: MediaQuery.of(context).size.width < 600 ? 20 : 40),
              padding: EdgeInsets.only(
                  left: 20,
                  right: MediaQuery.of(context).size.width < 600 ? 90 : 70,
                  bottom: 10,
                  top: MediaQuery.of(context).size.width < 600 ? 10 : 0),
              child: Text.rich(
                TextSpan(
                  text: widget.title!,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width < 600 ? 40 : 70,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey.shade600),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 28.0),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: darkGrey,
                        border: Border.all(
                            color: Colors.grey.shade600,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70)),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                              "Introducing the Multi-Purpose Utility Tool: your all-in-one solution for any task. Crafted for durability and convenience, this sleek device features a knife blade, screwdriver heads, bottle opener, and more. From DIY projects to outdoor adventures, it's the perfect companion. Compact and portable, it fits easily into pockets or toolboxes. Upgrade your toolkit today and experience the versatility of the Multi-Purpose Utility Tool.Introducing the Multi-Purpose Utility Tool: your all-in-one solution for any task. Crafted for durability and convenience, this sleek device features a knife blade, screwdriver heads, bottle opener, and more. From DIY projects to outdoor adventures, it's the perfect companion. Compact and portable, it fits easily into pockets or toolboxes. Upgrade your toolkit today and experience the versatility of the Multi-Purpose Utility Tool.",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Divider(color: Colors.grey.shade600),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin:
                        const EdgeInsets.only(left: 38.0, right: 38, top: 30),
                    decoration: BoxDecoration(color: darkGrey),
                    child: TextFormField(
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      maxLines: 4,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        labelText: 'Comment',
                        // alignLabelWithHint: true,
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade600,
                        ),
                        floatingLabelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.grey.shade600,
                              width: 1.0,
                              style: BorderStyle.solid),
                        ),
                        disabledBorder: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.grey.shade600,
                              width: 1.0,
                              style: BorderStyle.solid),
                        ),
                        focusedBorder: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.grey.shade600,
                              width: 1.0,
                              style: BorderStyle.solid),
                        ),
                        border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.grey.shade600,
                              width: 1.0,
                              style: BorderStyle.solid),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 200),
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        child: const Icon(
          Icons.download,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: showSizedBox ? bottomSheetBuilder() : null,
    );
  }

  Widget imageSliderDetailsBuilder() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 38, bottom: 40),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 20,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 4),
                  borderRadius: BorderRadius.circular(12)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  mainImg,
                  height: MediaQuery.of(context).size.width < 600 ? 250 : 400.0,
                  width: MediaQuery.of(context).size.width < 600
                      ? MediaQuery.of(context).size.width
                      : 650.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 130,
              width: MediaQuery.of(context).size.width,
              color: darkGrey,
              // padding: const EdgeInsets.all(10),
              child: CarouselSlider.builder(
                options: CarouselOptions(
                    scrollDirection: Axis.horizontal,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                    enlargeCenterPage: true,
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlay: false,
                    enableInfiniteScroll: true,
                    initialPage: 5,
                    viewportFraction: 0.4,
                    pageSnapping: true),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return isSliderItemTab(context, index);
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 320,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: darkGrey,
                      border: Border.all(
                          color: Colors.grey.shade600,
                          width: 1.0,
                          style: BorderStyle.solid)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(' App Details',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold)),
                      Divider(color: Colors.grey.shade600, height: 1),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Release Date - 17th May,2024',
                                  style: TextStyle(
                                      height: 2,
                                      fontSize: 18,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal)),
                              Text('Size - 5 MB',
                                  style: TextStyle(
                                      height: 2,
                                      fontSize: 18,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal)),
                              Text('Version - V02',
                                  style: TextStyle(
                                      height: 2,
                                      fontSize: 18,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal)),
                            ]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 320,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: darkGrey,
                      border: Border.all(
                          color: Colors.grey.shade600,
                          width: 1.0,
                          style: BorderStyle.solid)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(' Requirements',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold)),
                      Divider(color: Colors.grey.shade600, height: 1),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Requirement 1',
                                  style: TextStyle(
                                      height: 2,
                                      fontSize: 18,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal)),
                              Text('Requirement 2',
                                  style: TextStyle(
                                      height: 2,
                                      fontSize: 18,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal)),
                              Text('Requirement 3',
                                  style: TextStyle(
                                      height: 2,
                                      fontSize: 18,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal)),
                            ]),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget isSliderItemTab(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: GestureDetector(
          onTap: () {
            setState(() {
              mainImg = index == 0
                  ? widget.img!
                  : index == 1
                      ? img1
                      : index == 2
                          ? img2
                          : index == 3
                              ? img3
                              : img4;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                index == 0
                    ? widget.img!
                    : index == 1
                        ? img1
                        : index == 2
                            ? img2
                            : index == 3
                                ? img3
                                : img4,
                height: MediaQuery.of(context).size.width < 600 ? 100 : 120.0,
                width: MediaQuery.of(context).size.width < 600 ? 120 : 150.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
