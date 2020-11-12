class User{
  String id;
  String firstName;
  String lastName;
  String phoneNumber;
  String profilePicture;

  get fullName {
    return firstName + ' ' + lastName;
  }

  User({this.id, this.firstName, this.lastName, this.phoneNumber,
      this.profilePicture});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture']
    );
  }
}