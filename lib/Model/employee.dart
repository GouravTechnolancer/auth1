class UserProfile{
  String? id;
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  String? gender;
  String? age;
  String? dob;
  String? image;

  UserProfile({this.id, this.name, this.email, this.password, this.phoneNumber,this.gender,this.dob,this.age, this.image,});

  Map<String,dynamic> toJson(){
    return {
      "id": id,
      'name':name,
      'email':email,
      'password':password,
      'phoneNumber': phoneNumber,
      'gender':gender,
      'age':age,
      'dob':dob,
      'image': image
    };
  }

  factory UserProfile.fromMap(String id, Map<String, dynamic> map) {
    return UserProfile(
      id: id,
      name: map["name"],
      email: map["email"],
      password: map["password"],
      phoneNumber: map["phoneNumber"],
      gender: map["gender"],
      age: map["age"],
      dob: map["dob"],
      image: map['image']
    );
  }

}