import 'package:yenesuk/models/Image.dart';

class Item{
  String id;
  String name;
  String description;
  String condition;
  double price;
  String categoryId;
  String userId;
  String cityId;
  DateTime createdAt;
  List<Image> images;

  Item({this.id, this.name, this.description, this.condition, this.price,
      this.categoryId, this.userId, this.cityId, this.createdAt, this.images});

  factory Item.fromJson(Map<String, dynamic> json){
    List<Image> _images = new List<Image>();
    print(json['Images']);
    List<dynamic> rawImgs = json['Images'];
    rawImgs.forEach((image){
      _images.add(Image.fromJson(image));
    });
    print('images: $_images');

    return Item(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      condition: json['condition'],
      price: double.parse(json['price'].toString()),
      categoryId: json['categoryId'],
      userId: json['userId'],
      cityId: json['cityId'],
      createdAt: DateTime.parse(json['createdAt']),
      images: _images
    );
  }
}