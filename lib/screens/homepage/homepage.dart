import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yenesuk/blocs/initbloc/initbloc.dart';
import 'package:yenesuk/blocs/initbloc/initstate.dart';
import 'package:yenesuk/blocs/productsbloc/repo/productrepo.dart';
import 'package:yenesuk/blocs/searchbloc/searchbloc.dart';
import 'package:yenesuk/screens/homepage/widgets/category.dart';
import 'package:yenesuk/screens/homepage/widgets/draweritemwidget.dart';
import 'package:yenesuk/screens/postad/postadpage.dart';
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

  void scrollFeaturedProducts() {
    if (_scrollController.hasClients) {
      // print('${_scrollController.position.pixels} | ${_scrollController.position.minScrollExtent}');
      if (_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent) {
        _scrollController
            .animateTo(_scrollController.position.maxScrollExtent,
                duration: Duration(seconds: 5), curve: Curves.linear)
            .then((value) => scrollFeaturedProducts());
      } else {
        _scrollController.animateTo(_scrollController.position.minScrollExtent,
            duration: Duration(seconds: 5), curve: Curves.linear);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider(create: (context) => SearchBloc(productRepository: ProductRepository()), child: SearchPage())));
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
            BlocBuilder<InitBloc, InitState>(builder: (context, state) {
              if (state is FetchedState) {
                if (state.initData.featuredAds.length == 0) {
                  return Container();
                }
                return Container(
                  height: 175,
                  child: GestureDetector(
                    child: ListView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        children: state.initData.featuredAds
                            .map((e) => FeaturedProductWidget(
                                  id: e.id,
                                  name: e.name,
                                  price: e.price,
                                  image: e.images[0].imageUrl,
                                ))
                            .toList()),
                  ),
                );
              }
              return Container(
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
              );
            }),
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
                child:
                    BlocBuilder<InitBloc, InitState>(builder: (context, state) {
                  if (state is FetchedState) {
                    return GridView.builder(
                        padding: EdgeInsets.all(0.0),
                        shrinkWrap: true,
                        itemCount: state.initData.categories.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemBuilder: (context, index) {
                          if (index == state.initData.categories.length) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PostAdPage()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Center(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.add,
                                        color: Colors.white, size: 40.0),
                                    Text('Post ad',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))
                                  ],
                                )),
                              ),
                            );
                          }
                          return Category(
                              title: '${state.initData.categories[index].name}',
                              imageUrl:
                                  '${state.initData.categories[index].imageUrl}',
                              id: '${state.initData.categories[index].id}');
                        });
                  }
                  return Container();
                }),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            //   height: 50.0,
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //       color: Theme.of(context).primaryColor,
            //       borderRadius: BorderRadius.all(Radius.circular(5.0))),
            //   child: FlatButton(
            //     onPressed: () {
            //
            //     },
            //     child: Text(
            //       'post ad',
            //       style: TextStyle(
            //           color: Colors.white, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // )
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
          DrawerItemWidget(title: 'My ads', goto: PostAdPage()),
          DrawerItemWidget(title: 'Post ad', goto: PostAdPage()),
          DrawerItemWidget(title: 'Profile', goto: PostAdPage()),
          DrawerItemWidget(title: 'About', goto: PostAdPage()),
        ],
      ),
    );
  }
}
