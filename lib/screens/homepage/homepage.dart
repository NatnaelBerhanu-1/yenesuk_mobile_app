import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yenesuk/screens/homepage/widgets/category.dart';
import 'package:yenesuk/screens/homepage/widgets/draweritemwidget.dart';
import 'package:yenesuk/screens/postad/postadpage.dart';
import 'package:yenesuk/screens/productspage/productspage.dart';
import 'package:yenesuk/screens/searchpage/searchpage.dart';
import 'package:yenesuk/widgets/featuredproduct.dart';
import 'package:yenesuk/widgets/loadingshimmer.dart';
import 'package:yenesuk/widgets/title.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  ScrollController _scrollController = new ScrollController();

  void scrollFeaturedProducts(){
    print('${_scrollController.position.pixels} | ${_scrollController.position.minScrollExtent}');
    if (_scrollController.position.pixels == _scrollController.position.minScrollExtent){
      _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(seconds: 5), curve: Curves.linear).then((value) => scrollFeaturedProducts());
    }else{
      _scrollController.animateTo(_scrollController.position.minScrollExtent, duration: Duration(seconds: 5), curve: Curves.linear);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
    .addPostFrameCallback((_) {
      scrollFeaturedProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        key: _drawerKey,
        drawer: _buildDrawer(context),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            Container(
              height: MediaQuery.of(context).padding.top,
              color: Theme.of(context).primaryColor,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
              child: Container(
                height: 64.0,
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.dehaze,
                        color: Colors.white,
                        size: 28.0,
                      ),
                      onPressed: () => {
                        if (!_drawerKey.currentState.isDrawerOpen)
                          {_drawerKey.currentState.openDrawer()}
                      },
                    ),
                    Expanded(
                        child: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      margin:
                          EdgeInsets.only(right: 10.0, top: 5.0, bottom: 5.0),
                      // color: Colors.white,
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('Search')
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 175,
              child: GestureDetector(
                child: ListView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          LoadingShimmer(),
                          LoadingShimmer(),
                          LoadingShimmer(),
                          LoadingShimmer(),
                          LoadingShimmer(),
                        ]),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            PrimaryTitle(title: "Category"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowGlow();
                  return true;
                },
                child: GridView.count(
                  padding: EdgeInsets.all(0.0),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  children: [
                    Category(
                      title: 'Electronics',
                    ),
                    Category(
                      title: 'Clothes',
                    ),
                    Category(
                      title: 'Shoes',
                    ),
                    Category(
                      title: 'Beauty',
                    ),
                    Category(
                      title: 'Furniture',
                    ),
                    Category(
                      title: 'Other',
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: FlatButton(
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PostadPage()))
                },
                child: Text(
                  'post ad',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 200.0,
            padding: EdgeInsets.zero,
            color: Theme.of(context).primaryColor,
            child: Stack(fit: StackFit.expand, children: [
              Image.asset(
                'assets/images/renaissancedam.jpg',
                fit: BoxFit.fill,
              ),
              Container(
                height: 200.0,
                color: Theme.of(context).primaryColor.withOpacity(0.8),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Abay Online market',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        'Buy and Sell goods online',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          DrawerItemWidget(title: 'My ads', goto: ProductsPage()),
          DrawerItemWidget(title: 'Post ad', goto: PostadPage()),
          DrawerItemWidget(title: 'Profile', goto: ProductsPage()),
          DrawerItemWidget(title: 'About', goto: ProductsPage()),
        ],
      ),
    );
  }
}
