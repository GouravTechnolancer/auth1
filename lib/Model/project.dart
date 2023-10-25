import 'package:auth/Model/customer.dart';

class Project{
  String? name;
  int? budget;
  late Customer customer;
  DateTime startDate;
  DateTime tentativeEndDate;
  String? payment;
  // Project({this.name,this.budget});
  Project({ required this.startDate,required this.customer,required this.name,required this.budget,required this.tentativeEndDate,required this.payment});

  Map<String,dynamic> ToJson(){
    return {
      'name':name,
      'budget':budget,
      'customer' : customer,
      'startDate':startDate,
      'endDate':tentativeEndDate,
      'payment': payment
    };
  }
}