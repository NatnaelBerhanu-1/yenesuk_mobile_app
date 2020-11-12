import 'dart:convert';

import 'package:yenesuk/models/Item.dart';

class GetItemsResponse{
  List<Item> items;
  int page;
  int lastPage;

  GetItemsResponse({this.items, this.lastPage, this.page});

  factory GetItemsResponse.fromJson(Map<String, dynamic> json){
    List<Item> items = new List<Item>();
    List<dynamic> jsonItems = json['data'];
    jsonItems.forEach((element) {
      items.add(Item.fromJson(element));
    });


    return GetItemsResponse(
      items: items,
      lastPage: json['lastPage'],
      page: json['page']
    );
  }

}