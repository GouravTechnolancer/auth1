import 'package:auth/Model/employee.dart';

class Customer{
  String? name;
  String? gstno;
  List<UserProfile>? users;

  Customer({this.name,this.gstno,this.users});

  Map<String,dynamic> toJson(){
    return {
      'name':name,
      'gst' : gstno,
      'users':users!.map((e) => e.toJson()).toList(),
    };
  }
  factory Customer.fromMap(String id,Map<String,dynamic>json){
    return Customer(
      name:json['name'],
      gstno:json['gst'],
    );
  }

  @override
  String toString() {
    return 'Customer{name: $name,  gstno: $gstno';
  }

}
