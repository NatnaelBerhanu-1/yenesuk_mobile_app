import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yenesuk/blocs/initbloc/initbloc.dart';
import 'package:yenesuk/blocs/initbloc/initstate.dart';
import 'package:yenesuk/blocs/productsbloc/productbloc.dart';
import 'package:yenesuk/blocs/productsbloc/productevent.dart';
import 'package:yenesuk/blocs/productsbloc/productstate.dart';
import 'package:yenesuk/blocs/productsbloc/repo/productrepo.dart';
import 'package:yenesuk/blocs/searchbloc/searchbloc.dart';
import 'package:yenesuk/models/Item.dart';
import 'package:yenesuk/models/category.dart';
import 'package:yenesuk/screens/productspage/widgets/product.dart';
import 'package:yenesuk/screens/productspage/widgets/tryagain.dart';
import 'package:yenesuk/screens/searchpage/searchpage.dart';
import 'package:yenesuk/widgets/loadingshimmer.dart';

enum Status {
  fetching,
  fetched,
  error,
}

class ProductsPage extends StatefulWidget {
  final categoryId;
  ProductsPage({@required this.categoryId}) : assert(categoryId != null);

  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState(categoryId);
  }
}

class _ProductsPageState extends State<ProductsPage>
    with SingleTickerProviderStateMixin {
  String _activeCategory;
  AnimationController _animationController;
  Animation _animation;
  _ProductsPageState(String activeCat) {
    _activeCategory = activeCat;
  }
  int _page = 0;
  int _lastPage = 0;
  List<Item> _items = List<Item>();
  var _productScrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

  }

  @override
  Widget build(BuildContext context) {
    _productScrollController.addListener(() {
      if(_productScrollController.position.atEdge) {
        if(_productScrollController.position.pixels != 0){
          if(_page < _lastPage){
            BlocProvider.of<ProductBloc>(context).add(GetProductsByCategoryEvent(page: _page+1, categoryId: widget.categoryId));
          }
        }
      }
    });
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Theme.of(context).primaryColor,
          ),
          Container(
            height: 64.0,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () => {Navigator.pop(context)},
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlocProvider(
                              create: (context) => SearchBloc(
                                  productRepository: ProductRepository()),
                              child: SearchPage())));
                    },
                    child: Container(
                      height: 50.0,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('Search')
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.filter_list,
                    color: Colors.white,
                  ),
                  onPressed: () => {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => _buildFilterBottomModal(),
                        backgroundColor: Color(0x00FF0000),
                        clipBehavior: Clip.none,
                        isScrollControlled: true)
                  },
                )
              ],
            ),
          ),
          BlocBuilder<InitBloc, InitState>(builder: (context, state) {
            if (state is FetchedState) {
              return Container(
                  height: 40.0,
                  color: Theme.of(context).primaryColor,
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.initData.categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: _buildCategory(
                                context, state.initData.categories[index]));
                      }));
            }
            return Container();
          }),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductFetchingState) {
                  if (_items.length == 0){
                    return _buildLoadingWidget();
                  }else{
                    return _buildProductsWidget(Status.fetching);
                  }
                }
                if (state is ProductFetchedState) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    _animationController.forward();
                  });
                  _lastPage = state.data.lastPage;
                  if(state.data.page == 0){
                    _items = state.data.items;
                  }else{
                    _items.addAll(state.data.items);
                  }
                  _page = state.data.page;
                  return _buildProductsWidget(Status.fetched);
                }
                if (state is ProductErrorState) {
                  if(_items.length == 0){
                    return RetryWidget(
                      onTap: () {
                        BlocProvider.of<ProductBloc>(context).add(
                            GetProductsByCategoryEvent(
                                categoryId: _activeCategory, page: _page));
                      },
                      message: 'Failed to get ads',
                    );
                  }else{
                    return _buildProductsWidget(Status.error);
                  }
                }
                if (state is ProductEmptyState) {
                  return Center(
                    child: Text(
                      'No ads found under this category. Try again later',
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProductsWidget(Status status) {
    return FadeTransition(
        opacity: _animation,
        child: StaggeredGridView.countBuilder(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            controller: _productScrollController,
            crossAxisCount: 2,
            mainAxisSpacing: 0.0,
            itemCount: _items.length + 1,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              if (index == _items.length){
                if(_page == _lastPage){
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:8.0),
                      child: Text(
                        'you have reached the end',
                        style: TextStyle(
                          color: Colors.black.withOpacity(.4)
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  );
                }else{
                  if(status == Status.error){
                    return GestureDetector(
                      onTap: (){
                        BlocProvider.of<ProductBloc>(context).add(GetProductsByCategoryEvent(page: _page+1, categoryId: widget.categoryId));
                      },
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical:8.0),
                            child: Text(
                              'Failed to load more data\ntap to load more',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(.4)
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                      ),
                    );
                  }else{
                    return Container(
                      height: 40.0,
                      child: Center(
                          child: SpinKitWave(
                            color: Theme.of(context).primaryColor,
                            size: 20.0,
                            duration: Duration(milliseconds: 1000),
                          )
                      ),
                    );
                  }
                }
              }
              return ProductWidget(
                id: _items[index].id,
                name: _items[index].name,
                image: _items[index].images[0].imageUrl,
                price: _items[index].price,
              );
            },
          staggeredTileBuilder: (int index) {
              if (index == _items.length){
                return StaggeredTile.fit(2);
              }else{
                return StaggeredTile.fit(1);
              }
          },
        ));
  }

  Widget _buildLoadingWidget() {
    return GridView.count(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      mainAxisSpacing: 15.0,
      crossAxisCount: 2,
      childAspectRatio: 130 / 136,
      scrollDirection: Axis.vertical,
      children: [
        LoadingShimmer(),
        LoadingShimmer(),
        LoadingShimmer(),
        LoadingShimmer(),
        LoadingShimmer(),
        LoadingShimmer(),
        LoadingShimmer(),
        LoadingShimmer(),
        LoadingShimmer(),
        LoadingShimmer(),
      ],
    );
  }

  Widget _buildFilterBottomModal() {
    return Container(
      padding: EdgeInsets.only(
          top: 16.0,
          left: 16.0,
          right: 16.0,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 0))
          ]),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Advanced Filter',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .apply(color: Theme.of(context).primaryColor),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Category'),
                  ),
                  InputDecorator(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5.0),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.grey))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: false,
                        items: <String>['One', 'Two', 'Three', 'Four']
                            .map((e) => DropdownMenuItem<String>(
                                  child: Text('$e'),
                                ))
                            .toList(),
                        onChanged: (String newVal) {
                          print(newVal);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Condition'),
                  ),
                  InputDecorator(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5.0),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.grey))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: false,
                        items: <String>['New', 'Abroad Used', 'Ethiopian Used']
                            .map((e) => DropdownMenuItem<String>(
                                  child: Text('$e'),
                                ))
                            .toList(),
                        onChanged: (String newVal) {
                          print(newVal);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('City'),
                  ),
                  InputDecorator(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5.0),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.grey))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: false,
                        items: <String>['AddisAbaba', 'Two', 'Three', 'Four']
                            .map((e) => DropdownMenuItem<String>(
                                  child: Text('$e'),
                                ))
                            .toList(),
                        onChanged: (String newVal) {
                          print(newVal);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Min Price'),
                  ),
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(signed: false),
                    decoration: InputDecoration(
                        hintText: '0',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10.0),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.grey))),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Max Price'),
                  ),
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(signed: false),
                    decoration: InputDecoration(
                        hintText: 'unlimited',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10.0),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.grey))),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              margin: EdgeInsets.only(bottom: 16.0),
              child: FlatButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {},
                child: Text('Apply'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(BuildContext context, Category category) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _page = 0;
            _lastPage = 0;
            _items = List<Item>();
            _activeCategory = category.id;
            BlocProvider.of<ProductBloc>(context)
                .add(GetProductsByCategoryEvent(categoryId: _activeCategory, page: 0));
          });
        },
        child: _activeCategory == category.id
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  '${category.name[0].toUpperCase()}${category.name.substring(1)}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ))
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  '${category.name[0].toUpperCase()}${category.name.substring(1)}',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ));
  }
}
