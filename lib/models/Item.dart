import 'package:yenesuk/models/Image.dart';
import 'package:yenesuk/models/category.dart';
import 'package:yenesuk/models/city.dart';
import 'package:yenesuk/models/user.dart';

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
  Category category;
  User user;
  City city;


  Item({this.id, this.name, this.description, this.condition, this.price,
      this.categoryId, this.userId, this.cityId, this.createdAt, this.images, this.category, this.user, this.city});

  factory Item.fromJson(Map<String, dynamic> json){
    List<Image> _images = new List<Image>();
    print(json['Images']);
    List<dynamic> rawImgs = json['Images'];
    if (rawImgs != null)
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

  factory Item.fromJsonAll(Map<String, dynamic> json){
    Item item = Item.fromJson(json);
    item.city = City.fromJson(json['City']);
    item.user = User.fromJson(json['User']);
    item.category = Category.fromJson(json['Category']);
    return item;
  }
}