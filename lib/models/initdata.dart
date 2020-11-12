import 'package:yenesuk/models/Item.dart';
import 'package:yenesuk/models/category.dart';

class InitData{
  List<Category> categories;
  List<Item> featuredAds;

  InitData({this.categories, this.featuredAds});

  factory InitData.fromJson(Map<String, dynamic> json){
    List<Category> categories = new List<Category>();
    List<Item> featuredAds = new List<Item>();

    List<dynamic> rawCat = json['categories'];
    List<dynamic> rowAds = json['featuredAds'];

    rawCat.forEach((element) {
      categories.add(Category.fromJson(element));
    });

    rowAds.forEach((element) {
      featuredAds.add(Item.fromJson(element));
    });

    return InitData(
      categories: categories,
      featuredAds: featuredAds
    );
  }
}