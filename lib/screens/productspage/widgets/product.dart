import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yenesuk/blocs/productsbloc/productdetailbloc.dart';
import 'package:yenesuk/blocs/productsbloc/productevent.dart';
import 'package:yenesuk/screens/productdetail/productdetailspage.dart';

class ProductWidget extends StatelessWidget {
  final String image, name, id;
  final DateTime createdAt;
  final double price;

  ProductWidget(
      {@required this.id, @required this.image, @required this.name, @required this.price, @required this.createdAt})
      : assert(image != null && name != null && price != null && id != null && createdAt != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ProductDetailsBloc>(context).add(GetSingleProductEvent(id: id));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductDetailsPage(id: id,)));
      },
      child: Container(
        decoration: BoxDecoration(
            // border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        padding: EdgeInsets.symmetric(vertical: 10.0),
        width: 130.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.black,
              ),
              child: Center(
                child: ClipRRect(
                  // borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(9.0), topRight: Radius.circular(9.0)),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: CachedNetworkImage(
                    imageUrl: '$image',
                    placeholder: (context, url) => Container(
                      color: Colors.grey[300],
                      height: 100.0,
                    ),
                    height: 100.0,
                    // width: 130.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$name',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      '${createdAt.day}/${createdAt.month}/${createdAt.year} ${createdAt.hour}:${createdAt.minute}',
                      style: TextStyle(
                          color: Colors.black26,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      'ETB $price',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor.withOpacity(.9),
                          fontSize: 16.0),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
