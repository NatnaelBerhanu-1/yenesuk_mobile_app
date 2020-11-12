class Category{
  String id;
  String name;
  String imageUrl;

  Category({this.id, this.name, this.imageUrl});

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl']
    );
  }
}