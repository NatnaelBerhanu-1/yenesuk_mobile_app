import 'dart:convert';
import 'dart:wasm';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:yenesuk/baseservice.dart';
import 'package:yenesuk/models/requests/createAdRequest.dart';
import 'package:http/http.dart' as http;

import '../../../cloudinaryhelper.dart';

class PostAdService extends BaseService {

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
      var body = {
        "name": adRequest.name,
        "categoryId": adRequest.categoryId,
        "condition": adRequest.condition,
        "cityId": adRequest.cityId,
        "price": adRequest.price,
        "description": adRequest.description,
        "images": images,
        "userId": "be9c0eab-9e03-4ef7-bf77-6f3b41d9f32a"
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