import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yenesuk/screens/productdetail/productdetailspage.dart';

class FeaturedProductWidget extends StatelessWidget {
  final String image, name, id;
  final double price;

  FeaturedProductWidget(
      {@required this.id, @required this.image, @required this.name, @required this.price})
      : assert(image != null && name != null && price != null && id != null);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage(id: id,)));
      },
      child: Container(
        decoration: BoxDecoration(
            // border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        width: 130.0,
        child: Stack(
          children: [
            Column(
            children: <Widget>[
              ClipRRect(
                // borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(9.0), topRight: Radius.circular(9.0)),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0)
                ),
                child: CachedNetworkImage(
                  imageUrl: '$image',
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    height: 100.0,
                  ),
                  height: 100.0,
                  // width: 130.0,
                  fit: BoxFit.fill,
                )
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '$name',
                        style: TextStyle(color: Colors.black, fontSize: 14.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'ETB $price',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor.withOpacity(.9),
                            fontWeight: FontWeight.w800,
                            fontSize: 16.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ]),
              )
            ],
          ),
            Container(
              color: Theme.of(context).accentColor,
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Featured',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
