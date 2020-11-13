import 'package:yenesuk/models/Item.dart';
import 'package:yenesuk/models/category.dart';
import 'package:yenesuk/models/city.dart';

class InitData{
  List<Category> categories;
  List<Item> featuredAds;
  List<City> cities;

  InitData({this.categories, this.featuredAds, this.cities});

  factory InitData.fromJson(Map<String, dynamic> json){
    List<Category> categories = new List<Category>();
    List<Item> featuredAds = new List<Item>();
    List<City> cities = new List<City>();

    List<dynamic> rawCat = json['categories'];
    List<dynamic> rowAds = json['featuredAds'];
    List<dynamic> rowCities = json['cities'];

    rawCat.forEach((element) {
      categories.add(Category.fromJson(element));
    });

    rowAds.forEach((element) {
      featuredAds.add(Item.fromJson(element));
    });

    rowCities.forEach((element) {
      cities.add(City.fromJson(element));
    });

    return InitData(
      categories: categories,
      featuredAds: featuredAds,
      cities: cities
    );
  }
}