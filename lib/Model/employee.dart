class Employee{
  String? name;
  String? email;
  String? password;
  String? phoneNumber;


  Employee({this.name, this.email, this.password, this.phoneNumber});

  Map<String,dynamic> toJson(){
    return {
      'name':name,
      'email':email,
      'password':password,
      'phoneNumber': phoneNumber
    };
  }
}