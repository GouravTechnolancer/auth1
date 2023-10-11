import 'package:auth/Model/employee.dart';

class Customer{
  String?id;
  String? name;
  String? gstno;
  List<UserProfile>? users;

  Customer({this.name,this.gstno,this.users,this.id});

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'name':name,
      'gst' : gstno,
      'users':users!.map((e) => e.toJson()).toList(),
    };
  }
  factory Customer.fromMap(String id,Map<String,dynamic>json){
    return Customer(
      id: id,
      name:json['name'],
      gstno:json['gst'],
      users: json['users'].map<UserProfile>((e)=> UserProfile.fromMap(e['id'], e)).toList()
    );
  }

  @override
  String toString() {
    return 'Customer{name: $name,  gstno: $gstno';
  }

}
