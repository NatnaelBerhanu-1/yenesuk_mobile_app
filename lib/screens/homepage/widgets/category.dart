import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yenesuk/blocs/productsbloc/productbloc.dart';
import 'package:yenesuk/blocs/productsbloc/productevent.dart';
import 'package:yenesuk/screens/productspage/productspage.dart';

class Category extends StatelessWidget {
  final String title, imageUrl, id;

  Category({@required this.title, @required this.imageUrl, @required this.id}):assert(title!=null&&imageUrl!=null&&id!=null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ProductBloc>(context).add(GetProductsByCategoryEvent(categoryId: id, page: 0));
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsPage(categoryId: id)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(
            //   Icons.laptop,
            //   color: Theme.of(context).primaryColor,
            //   size: 40.0,
            // ),
            CachedNetworkImage(
              imageUrl: '$imageUrl',
              height: 30.0,
              width: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
              child: Text(
                '${title[0].toUpperCase()}${title.substring(1)}',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
