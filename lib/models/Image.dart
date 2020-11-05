class Image{
  int id;
  String imageUrl;

  Image({this.imageUrl});

  factory Image.fromJson(Map<String, dynamic> json){
    return Image(
      imageUrl: json['imageUrl']
    );
  }
}