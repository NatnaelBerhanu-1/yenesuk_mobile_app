import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:yenesuk/screens/productimages/productimages.dart';

class ProductCarousel extends StatefulWidget{
  final List<String> items;
  
  ProductCarousel({@required this.items});

  @override
  _ProductCarouselState createState() => _ProductCarouselState();
}

class _ProductCarouselState extends State<ProductCarousel> {
  int _activeIndex;

  @override
  void initState() {
    _activeIndex = 0;
    print('items: ${widget.items}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 250.0,
            viewportFraction: 0.95,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            initialPage: 0,
            onPageChanged: (position, reason){
              print('carousel position: $position');
              setState(() {
                _activeIndex = position;
              });
            },
          ),
          items: widget.items.map((e) => Hero(
            tag: 'adPhoto${widget.items.indexOf(e)}',
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductImages(images: widget.items, initialPage: widget.items.indexOf(e))));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  //   border: Border.all(
                  //   width: 1.0,
                  //   color: Colors.black12
                  // )
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Container(
                      color: Colors.grey[300],
                    ),
                    imageUrl:'$e',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          )).toList(),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: widget.items.map((e) {
              return Container(
              margin: EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                  color: widget.items.indexOf(e) == _activeIndex ?  Theme.of(context).primaryColor:Colors.grey.withOpacity(.4),
                  borderRadius: BorderRadius.all(
                      Radius.circular(4)
                  )
              ),
              width: 8,
              height: 8,
            );
              }).toList(),
        ))
      ],
    );
  }
}