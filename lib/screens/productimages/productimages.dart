import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductImages extends StatefulWidget {
  final List<String> images;
  final int initialPage;
  ProductImages({@required this.images, @required this.initialPage})
      : assert(images != null && initialPage != null);

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int _activeImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _activeImage = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onVerticalDragEnd: (detail){
          Navigator.pop(context);
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  initialPage: widget.initialPage,
                  enableInfiniteScroll: false,
                  viewportFraction: 1.0,
                  onPageChanged: (page, reason) {
                    setState(() {
                      _activeImage = page;
                    });
                  }),
              items: widget.images
                  .map((e) => Hero(
                        tag: 'adPhoto${widget.images.indexOf(e)}',
                        child: CachedNetworkImage(
                          imageUrl: e,
                          fit: BoxFit.contain,
                        ),
                      ))
                  .toList(),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.only(right: 15.0),
                alignment: Alignment.center,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon:
                          Icon(Icons.arrow_back, size: 24.0, color: Colors.white),
                    ),
                    Text(
                      '${_activeImage + 1}/${widget.images.length}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
