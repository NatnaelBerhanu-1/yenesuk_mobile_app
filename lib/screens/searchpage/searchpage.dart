import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yenesuk/blocs/productsbloc/productevent.dart';
import 'package:yenesuk/blocs/productsbloc/productstate.dart';
import 'package:yenesuk/blocs/productsbloc/repo/productrepo.dart';
import 'package:yenesuk/blocs/searchbloc/searchbloc.dart';
import 'package:yenesuk/screens/productspage/widgets/tryagain.dart';
import 'package:yenesuk/screens/searchpage/widgets/searchitem.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchText = "";
  var _controller = TextEditingController();
  int _page = 0;

  @override
  Widget build(BuildContext context) {
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
                autofocus: _searchText.isEmpty ?true: false,
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
                    BlocProvider.of<SearchBloc>(context)
                        .add(SearchTextChangedEvent(searchText: searchVal, page: _page));
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
            padding: const EdgeInsets.only(top:8.0, left: 10.0, right:10.0),
            child: BlocBuilder<SearchBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductFetchedState){
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: state.data.items.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return SearchItem(item: state.data.items[index]);
                      },
                    );
                  }
                  if (state is ProductEmptyState){
                    return Center(
                      child: Text(
                        'Nothing found'
                      )
                    );
                  }
                  if (state is ProductErrorState){
                    return RetryWidget(
                      onTap: () {
                        BlocProvider.of<SearchBloc>(context).add(SearchTextChangedEvent(searchText: _searchText, page: _page));
                      },
                      message: 'Something went wrong',
                    );
                  }
                  if (state is ProductFetchingState){
                    return Center(
                        child: Text(
                            'Searching...'
                        )
                    );
                  }
                  else{
                    return Container();
                  }
            }),
          ),
        )
      ],
    ),
      );
  }
}
