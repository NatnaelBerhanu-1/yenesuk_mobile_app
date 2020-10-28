import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yenesuk/screens/productspage/widgets/product.dart';

class ProductsPage extends StatefulWidget {
  int active_index = 0;
  final categories = [
    "All",
    "Electronics",
    "Clothes",
    "Shoes",
    "Beauty",
    "Furniture",
    "Other"
  ];

  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState(active_index);
  }
}

class _ProductsPageState extends State<ProductsPage> {
  int _activeCategory;
  RangeValues _currentRangeValues = new RangeValues(0, 50000000);

  _ProductsPageState(int activeCat) {
    _activeCategory = activeCat;
  }

  @override
  Widget build(BuildContext context) {
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
          Container(
              height: 40.0,
              color: Theme.of(context).primaryColor,
              child: ListView.builder(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: _buildCategory(index));
                  })),
          Expanded(
            child: Stack(
              children: [
                GridView.count(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  mainAxisSpacing: 15.0,
                  crossAxisCount: 2,
                  childAspectRatio: 130 / 136,
                  scrollDirection: Axis.vertical,
                  children: [
                    ProductWidget(),
                    ProductWidget(),
                    ProductWidget(),
                    ProductWidget(),
                    ProductWidget(),
                    ProductWidget(),
                    ProductWidget(),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFilterBottomModal() {
    return Container(
      padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0,bottom: MediaQuery.of(context).viewInsets.bottom),
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

  Widget _buildCategory(int index) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _activeCategory = index;
            print('$index');
          });
        },
        child: _activeCategory == index
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  '${widget.categories[index]}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ))
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  '${widget.categories[index]}',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ));
  }
}
