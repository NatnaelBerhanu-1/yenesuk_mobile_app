import 'dart:convert';

import 'package:yenesuk/baseservice.dart';
import 'package:yenesuk/models/initdata.dart';
import 'package:http/http.dart' as http;

class InitService extends BaseService{
  InitData _initData;

  Future<InitData> getInitData() async {
    // if(_initData!=null)
    // {
    //   print('from cache');
    //   return _initData;
    // }
    print('getting data');
    var response = await http.get('$baseUrl/v1/init');
    print(response.statusCode);
    if(response.statusCode == 200){
      print(jsonDecode(response.body));
      _initData = InitData.fromJson(jsonDecode(response.body));
      return _initData;
    }else{
      throw Exception('Failed to get data');
    }
  }
}