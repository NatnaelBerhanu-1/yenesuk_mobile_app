class City{
  String id;
  String name;

  City({this.id, this.name});

  factory City.fromJson(Map<String, dynamic> json){
    return City(
      id: json['id'],
      name: json['name']
    );
  }
}