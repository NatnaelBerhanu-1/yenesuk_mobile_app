import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      width: 130.0,
      child: Column(
        children: <Widget>[
          ClipRRect(
            // borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(9.0), topRight: Radius.circular(9.0)),
            borderRadius: BorderRadius.all(
              Radius.circular(5.0)
            ),
            child: Image(
              image: AssetImage('assets/images/iphone.jpg'),
              // height: 100.0,
              // width: 130.0,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Apple iPhone 11 Pro max, 256GB, Midnight',
                    style: TextStyle(color: Colors.black, fontSize: 14.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Br 45000',
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
    );
  }
}
