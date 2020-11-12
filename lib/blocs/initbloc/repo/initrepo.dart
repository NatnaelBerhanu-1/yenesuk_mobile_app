import 'package:yenesuk/blocs/initbloc/service/initservice.dart';
import 'package:yenesuk/models/initdata.dart';

class InitRepository {
  InitService _initService = new InitService();

  Future<InitData> getInitData() async {
    return await _initService.getInitData();
  }

}