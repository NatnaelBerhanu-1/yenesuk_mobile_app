import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yenesuk/blocs/productsbloc/productevent.dart';
import 'package:yenesuk/blocs/productsbloc/productstate.dart';
import 'package:yenesuk/blocs/productsbloc/repo/productrepo.dart';
import 'package:yenesuk/blocs/searchbloc/searchbloc.dart';
import 'package:yenesuk/models/Item.dart';
import 'package:yenesuk/screens/productspage/widgets/tryagain.dart';
import 'package:yenesuk/screens/searchpage/widgets/searchitem.dart';

enum Status {
  fetching,
  fetched,
  error,
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchText = "";
  var _controller = TextEditingController();
  int _page = 0;
  int _lastPage = 0;
  List<Item> _items = List<Item>();

  var _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if(_scrollController.position.atEdge){
        if(_scrollController.position.pixels != 0){
          if(_page<_lastPage){
            BlocProvider.of<SearchBloc>(context).add(SearchTextChangedEvent(searchText: _searchText, page: _page+1));
          }
        }
      }
    });
    ProductRepository productRepository = ProductRepository();
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            height: 64.0 + MediaQuery.of(context).padding.top,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 28.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(
                    child: TextField(
                  textInputAction: TextInputAction.search,
                  controller: _controller,
                  autofocus: _searchText.isEmpty ? true : false,
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                  keyboardType: TextInputType.text,
                  onChanged: (newVal) {
                    setState(() {
                      _searchText = newVal;
                    });
                  },
                  onSubmitted: (searchVal) {
                    if (searchVal.length > 2) {
                      // do searching here
                      print('here');
                      searchVal = searchVal.trim();
                      setState(() {
                        _page = 0;
                      });
                      BlocProvider.of<SearchBloc>(context).add(
                          SearchTextChangedEvent(
                              searchText: searchVal, page: _page));
                    }
                  },
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.white70),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                )),
                if (_searchText.length > 0)
                  IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.white38,
                      size: 24.0,
                    ),
                    onPressed: () {
                      setState(() {
                        _searchText = "";
                      });
                      _controller.clear();
                    },
                  ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
              child: BlocBuilder<SearchBloc, ProductState>(
                  builder: (context, state) {
                if (state is ProductFetchedState) {
                  _lastPage = state.data.lastPage;
                  if (state.data.page == 0) {
                    _items = state.data.items;
                  } else {
                    _items.addAll(state.data.items);
                  }
                  _page = state.data.page;
                  return _buildSearchSuccessWidget(Status.fetched);
                }
                if (state is ProductEmptyState) {
                  return Center(child: Text('Nothing found'));
                }
                if (state is ProductErrorState) {
                  if (_items.length == 0) {
                    return RetryWidget(
                      onTap: () {
                        BlocProvider.of<SearchBloc>(context).add(
                            SearchTextChangedEvent(
                                searchText: _searchText, page: _page));
                      },
                      message: 'Something went wrong',
                    );
                  } else {
                    return _buildSearchSuccessWidget(Status.error);
                  }
                }
                if (state is ProductFetchingState) {
                  if (_items.length == 0) {
                    return Center(child: Text('Searching...'));
                  } else {
                    return _buildSearchSuccessWidget(Status.fetching);
                  }
                } else {
                  return Container();
                }
              }),
            ),
          )
        ],
      ),
    );
  }

  _buildSearchSuccessWidget(Status status) {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      itemCount: _items.length + 1,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == _items.length) {
          if (index == _items.length) {
            if (_page == _lastPage) {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'you have reached the end',
                  style: TextStyle(color: Colors.black.withOpacity(.4)),
                  textAlign: TextAlign.center,
                ),
              ));
            } else {
              if (status == Status.error) {
                return GestureDetector(
                  onTap: () {
                    // BlocProvider.of<ProductBloc>(context).add(LoadMoreProductsEvent(page: _page+1, categoryId: widget.categoryId));
                  },
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Failed to load more data\ntap to load more',
                      style: TextStyle(color: Colors.black.withOpacity(.4)),
                      textAlign: TextAlign.center,
                    ),
                  )),
                );
              } else {
                return Container(
                  height: 40.0,
                  child: Center(
                      child: SpinKitWave(
                    color: Theme.of(context).primaryColor,
                    size: 20.0,
                    duration: Duration(milliseconds: 1000),
                  )),
                );
              }
            }
          }
        }
        return SearchItem(item: _items[index]);
      },
    );
  }
}
