import 'dart:convert';

import 'package:yenesuk/baseservice.dart';
import 'package:yenesuk/models/Item.dart';
import 'package:http/http.dart' as http;
import 'package:yenesuk/models/responses/getitemsresponse.dart';

class ProductService extends BaseService{
  Future<GetItemsResponse> getItems(int page) async{
    if(page==null){
      page = 0;
    }
    var response = await http.get('$baseUrl/v1/items?page=$page' ).timeout(Duration(seconds: 10));
    // print('response: ${response.body}');
    if(response.statusCode == 200){
      return GetItemsResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Can't get items");
    }
  }

  Future<GetItemsResponse> searchItems(String searchKey,int page) async {
    var response = await http.get('$baseUrl/v1/items/search?q=$searchKey&page=$page');
    print('resp: ${response.request.url.toString()}');
    if(response.statusCode == 200){
      return GetItemsResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Can't search item");
    }
  }

  Future<Item> getSingleItem(String id) async {
    var response = await http.get('$baseUrl/v1/items/$id?assoc=true').timeout(Duration(seconds: 10));
    print('resp: ${response.body}');
    if(response.statusCode == 200){
      var item = Item.fromJsonAll(jsonDecode(response.body));
      print('item: $item');
      return item;
    }else{
      throw Exception("Can't get item");
    }
  }

  Future<GetItemsResponse> getItemsByCategory(String categoryId, int page) async {
    var response = await http.get('$baseUrl/v1/items?filterBy=category&cat=$categoryId&page=$page').timeout(Duration(seconds: 10));
    print('resp: ${response.request.url.toString()}');
    if(response.statusCode == 200){
      return GetItemsResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Can't get item");
    }
  }
}