import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchText = "";
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            height: 64.0+MediaQuery.of(context).padding.top,
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
                      autofocus: true,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (newVal){
                        setState(() {
                          _searchText = newVal;
                        });
                      },
                      onSubmitted: (searchVal){
                        print(searchVal);
                      },
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.white70
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                    )
                ),
                if(_searchText.length > 0)
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
          )
        ],
      ),
    );
  }
}