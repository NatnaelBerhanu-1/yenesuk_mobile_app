import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yenesuk/blocs/productsbloc/productdetailbloc.dart';
import 'package:yenesuk/blocs/productsbloc/productevent.dart';
import 'package:yenesuk/models/Item.dart';
import 'package:yenesuk/screens/productdetail/productdetailspage.dart';

class SearchItem extends StatelessWidget{
  final Item item;
  SearchItem({@required this.item}):assert(item!=null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        BlocProvider.of<ProductDetailsBloc>(context).add(GetSingleProductEvent(id: item.id));
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductDetailsPage(id: item.id)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              // borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(9.0), topRight: Radius.circular(9.0)),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: CachedNetworkImage(
                imageUrl: '${item.images[0].imageUrl}',
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  height: 80.0,
                ),
                height: 80.0,
                width: 120.0,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${item.name}',
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
                      'ETB ${item.price}',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor.withOpacity(.9),
                          fontSize: 16.0),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}