import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yenesuk/screens/productdetail/widgets/productcarousel.dart';

class ProductDetailsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Product Details'
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                  ),
                  child: ProductCarousel(items: ['assets/images/iphone.jpg','assets/images/iphonee.jpg','assets/images/iphoneee.jpg'],),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10.0),
                  child: Text(
                    'Br 30,000',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  child: Text(
                    'Apple iPhone 11 Pro Max, 256GB, Midnight Green, Fully Unlocked (Renewed)',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  child: Text(
                    'Shoot amazing videos and photos with the Ultra Wide, Wide, and Telephoto cameras. Capture your best low-light photos with Night mode. Watch HDR movies and shows on the 6.5-inch Super Retina XDR display – the brightest iPhone display yet. Experience unprecedented performance with A13 Bionic for gaming',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 76.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _detailWidget('Condition', 'New', context),
                            _detailWidget('Category', 'Electronics', context),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _detailWidget('City', 'Addis Ababa', context),
                            _detailWidget('Price', 'Br 30,000', context),
                          ],
                        ),
                      ],
                  )
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    spreadRadius: 5,
                    offset: Offset(0, 3)
                  )
                ]
              ),
              height: 60.0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CircleAvatar(
                    backgroundImage:  AssetImage(
                      'assets/images/profilepic.jpg',
                    ),
                    radius: 25.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0 ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'John Doe',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            '+251912131415',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: 80,
                    color: Theme.of(context).primaryColor,
                    child: Icon(
                      Icons.call,
                      color: Colors.white,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _detailWidget(title, value, context){
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '$title',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '$value',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 16.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}