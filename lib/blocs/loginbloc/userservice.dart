import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:yenesuk/baseservice.dart';
import 'package:yenesuk/cloudinaryhelper.dart';
import 'package:yenesuk/models/user.dart';
import 'package:http/http.dart' as http;

class UserService extends BaseService{
  Future<User> getUser(String id) async {
    var response = await http.get('$baseUrl/v1/users/$id');
    if(response.statusCode == 200){
      User user = User.fromJson(jsonDecode(response.body));
      return user;
    }else{
      throw Exception('User not found');
    }
  }

  Future<User> checkAndCreateUser(User user) async {
    var body = {
      "phoneNumber": user.phoneNumber,
    };
    print(body);
    var response = await http.post('$baseUrl/v1/users',body: json.encode(body), headers: {"Content-Type": "application/json; charset=utf-8"});
    if(response.statusCode == 201){
      print(response.body);
      User user = User.fromJson(jsonDecode(response.body));
      print('here');
      return user;
    }else{
      print(response.body);
      throw Exception('Something went wrong');
    }
  }

  Future<User> updateUser(User user, Asset image) async {
    try{
      CloudinaryResponse uploadedImage = await cloudinary.uploadFile(await CloudinaryFile.fromFutureByteData(image.getByteData(), identifier: image.identifier));
      var body = {
        "firstName":user.firstName,
        "lastName":user.lastName,
        "profilePicture":uploadedImage.secureUrl
      };
      var response = await http.patch('$baseUrl/v1/users/${user.id}', body: json.encode(body), headers: {"Content-Type": "application/json; charset=utf-8"});
      print('${response.body}');
      if(response.statusCode == 200){
        User user = User.fromJson(jsonDecode(response.body));
        return user;
      }else{
        throw Exception('Something went wrong');
      }
    }catch(error){
      print(error);
      throw Exception('Something went wrong');
    }

  }
}