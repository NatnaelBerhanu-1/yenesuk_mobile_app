import 'dart:convert';
import 'dart:ffi';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:yenesuk/baseservice.dart';
import 'package:yenesuk/cloudinaryhelper.dart';
import 'package:yenesuk/models/Item.dart';
import 'package:http/http.dart' as http;
import 'package:yenesuk/models/requests/createAdRequest.dart';
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

  Future<Void> postAd({CreateAdRequest adRequest}) async {
    print('posting ad');
    try{
      List<CloudinaryResponse> uploadedImages = await cloudinary.multiUpload(
        adRequest.images.map((image) => CloudinaryFile.fromFutureByteData(
          image.getByteData(),
          identifier: image.identifier,
        ),
        ).toList(),
      );
      List<String> images = new List<String>();
      uploadedImages.forEach((element) {
        images.add(element.secureUrl);
      });
      // TODO: change the userId
      var body = {
        "name": adRequest.name,
        "categoryId": adRequest.categoryId,
        "condition": adRequest.condition,
        "cityId": adRequest.cityId,
        "price": adRequest.price,
        "description": adRequest.description,
        "images": images,
        "userId": adRequest.userId
      };
      var response = await http.post('$baseUrl/v1/items',body: json.encode(body), headers: {"Content-Type": "application/json; charset=utf-8"});
      print(response.body);
      print(response.statusCode);
      if(response.statusCode!=201){
        throw Exception('Failed to post ad');
      }
    }catch(e){
      throw Exception('Failed to post ad');
    }

  }
}