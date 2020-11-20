import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:yenesuk/blocs/loginbloc/userservice.dart';
import 'package:yenesuk/models/user.dart';

class UserRepository{
  UserService _userService = UserService();
  Future<User> checkAndCreateUser(User user) async {
    return await _userService.checkAndCreateUser(user);
  }

  Future<User> updateUser(User user, Asset image) async{
    return await _userService.updateUser(user, image);
  }
}