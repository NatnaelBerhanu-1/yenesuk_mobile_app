import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yenesuk/blocs/productsbloc/productdetailbloc.dart';
import 'package:yenesuk/blocs/productsbloc/productevent.dart';
import 'package:yenesuk/blocs/productsbloc/productstate.dart';
import 'package:yenesuk/models/Item.dart';
import 'package:yenesuk/screens/productdetail/widgets/productcarousel.dart';
import 'package:yenesuk/screens/productspage/widgets/tryagain.dart';

class ProductDetailsPage extends StatefulWidget {
  final String id;
  ProductDetailsPage({@required this.id}):assert(id!=null);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 100)
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ad Details'),
      ),
      body: BlocBuilder<ProductDetailsBloc, ProductState>(
        builder: (context, state){
          if(state is ProductFetchedState){
            WidgetsBinding.instance
            .addPostFrameCallback((timeStamp) {
              _animationController.forward();
            });
            return _successWidget(context, state.data.items[0]);
          }
          if(state is ProductFetchingState){
            return Center(
              child: SpinKitWave(
                color: Theme.of(context).primaryColor,
                size: 20.0,
                duration: Duration(milliseconds: 1000),
              )
            );
          }
          if(state is ProductErrorState){
            return RetryWidget(
              onTap: (){
                BlocProvider.of<ProductDetailsBloc>(context).add(GetSingleProductEvent(id: widget.id));
              },
              message: 'Failed to get ad detail'
            );
          }
          return Container();
        }
      ),
    );
  }

  Widget _successWidget(BuildContext context, Item item){
    return FadeTransition(
      opacity: _animation,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(),
                  child: ProductCarousel(
                    items: item.images.map((e) => e.imageUrl).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'ETB ${item.price}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  child: Text(
                    '${item.name}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  child: Text(
                    '${item.description}',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 16.0, fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 8.0, bottom: 76.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _detailWidget('Condition', '${item.condition}', context),
                            _detailWidget('Category', '${item.category.name}', context),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _detailWidget('City', '${item.city.name}', context),
                            _detailWidget('Price', '${item.price}', context),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    spreadRadius: 5,
                    offset: Offset(0, 3))
              ]),
              height: 60.0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      '${item.user.profilePicture}',
                    ),
                    radius: 25.0,
                    backgroundColor: Colors.grey,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${item.user.fullName}',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${item.user.phoneNumber}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      var url = "tel: ${item.user.phoneNumber}";
                      if(await canLaunch(url)){
                        await launch(url);
                      }
                      else{
                        throw 'Could not launch $url';
                      }
                    },
                    child: Container(
                      height: double.infinity,
                      width: 80,
                      color: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.call,
                        color: Colors.white,
                        size: 30,
                      ),
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

  Widget _detailWidget(title, value, context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(.05),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0)
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '$title',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 4.0),
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
