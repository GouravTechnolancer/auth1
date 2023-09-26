class Employee{
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  String? gender;
  String? age;
  String? dob;


  Employee({this.name, this.email, this.password, this.phoneNumber,this.gender,this.dob,this.age});

  Map<String,dynamic> toJson(){
    return {
      'name':name,
      'email':email,
      'password':password,
      'phoneNumber': phoneNumber,
      'gender':gender,
      'age':age,
      'dob':dob
    };
  }
}