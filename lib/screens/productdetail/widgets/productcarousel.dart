import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
    _activeIndex = widget.items.length ~/2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 250.0,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            initialPage: widget.items.length~/2,
            onPageChanged: (position, reason){
              print('carousel position: $position');
              setState(() {
                _activeIndex = position;
              });
            },
          ),
          items: widget.items.map((e) => Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //   border: Border.all(
              //   width: 1.0,
              //   color: Colors.black12
              // )
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: Image.asset(
                '$e',
                fit: BoxFit.fill,
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