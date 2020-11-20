import 'package:multi_image_picker/multi_image_picker.dart';

class CreateAdRequest{
  String name;
  String description;
  String categoryId;
  String cityId;
  String condition;
  double price;
  String userId;
  List<Asset> images;
}