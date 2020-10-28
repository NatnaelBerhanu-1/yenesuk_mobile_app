import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yenesuk/screens/productspage/productspage.dart';

class Category extends StatelessWidget {
  final String title;

  Category({@required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsPage()))
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.black54, width: 1.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.laptop,
              color: Theme.of(context).primaryColor,
              size: 40.0,
            ),
            Text(
              '$title',
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }
}
