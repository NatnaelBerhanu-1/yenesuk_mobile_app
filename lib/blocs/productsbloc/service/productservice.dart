import 'dart:convert';

import 'package:yenesuk/baseservice.dart';
import 'package:yenesuk/models/Item.dart';
import 'package:http/http.dart' as http;

class ProductService extends BaseService{
  Future<List<Item>> getItems(int page) async{
    if(page==null){
      page = 0;
    }
    var response = await http.get('$baseUrl/v1/items?page=$page');
    // print('response: ${response.body}');
    if(response.statusCode == 200){
      List<Item> items = new List<Item>();
      List<dynamic> jsonItems = jsonDecode(response.body)['rows'];
      jsonItems.forEach((element) {
        items.add(Item.fromJson(element));
      });
      return items;
    }else{
      throw Exception("Can't get items");
    }
  }

  searchItems(String searchKey) {}
}