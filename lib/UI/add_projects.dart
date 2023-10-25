import 'dart:async';

import 'package:auth/Model/project.dart';
import 'package:auth/UI/manage_users.dart';
import 'package:auth/UI/mange_customer.dart';
import 'package:auth/variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../Model/customer.dart';


class AddProjects extends StatefulWidget {

  const AddProjects({super.key});

  @override
  State<AddProjects> createState() => _AddProjectsState();
}

class _AddProjectsState extends State<AddProjects> {
  Customer customer =Customer();
  List<Customer>? allCustomer = [];
  late StreamSubscription customerListener;
  TextEditingController userController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController startdate = TextEditingController();
  TextEditingController enddate = TextEditingController();
  late Project project;

  @override
  Widget build(BuildContext context) {
    print(startdate);
    print(enddate);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text('Add Projects'),backgroundColor: appbar,centerTitle: true,),
        body:Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                        label: Text('ProjectName'),
                        hintText: 'Enter Project Name',
                        border: OutlineInputBorder(),
                        suffix: Icon(Icons.person)
                    ),
                    onChanged: (value){
                    project.name = value;
                    },
                    validator: (val){
                      if(val!.isEmpty)  return 'Entered name musted';
                      return null;
                    },
                  ),const SizedBox(height: 5,),
                  TextFormField(style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                        label: Text('Budget'),
                        hintText: 'Budget',
                        border: OutlineInputBorder(),
                        suffix: Icon(Icons.app_registration)
                    ),
                    onChanged: (value){
                      project.budget = int.tryParse(value)!;
                    },
                    validator: (val){
                      if(val!.isEmpty)  return 'Entered Gstno must';
                      return null;
                    },
                  ),
                  const SizedBox(height: 5,),
                  TextFormField(style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                        label: Text('StartDate'),
                        hintText: 'StartDate',
                        border: OutlineInputBorder(),
                        suffix: Icon(Icons.calendar_month)
                    ),
                    controller: startdate,
                    onTap: ()async{
                    final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100));
                        if(pickedDate !=null){
                          setState(() {
                            startdate.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                            project.startDate = startdate as DateTime;
                          });
                        }
                    },
                    validator: (val){
                      if(val!.isEmpty)  return 'Entered Date must';
                      return null;
                    },
                  ),
                  SizedBox(height: 5,),
                  TextFormField(style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                        label: Text('TentativeEndDate'),
                        hintText: 'tentativeEndDate',
                        border: OutlineInputBorder(),
                        suffix: Icon(Icons.calendar_month)
                    ),
                    controller: enddate,
                    onTap: ()async{
                      final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100));
                      if(pickedDate !=null){
                        setState(() {
                          enddate.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                          project.tentativeEndDate = enddate as DateTime;
                        });
                      }
                    },
                    validator: (val){
                      if(val!.isEmpty)  return 'Entered Date must';
                      return null;
                    },
                  ),
                  SizedBox(height: 5,),
                  TextFormField(style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                        label: Text('Payment'),
                        hintText: 'Enter Payment',
                        border: OutlineInputBorder(),
                        suffix: Icon(Icons.person)
                    ),
                    onChanged: (value){
                      project.payment = value;
                    },
                    validator: (val){
                      if(val!.isEmpty)  return 'Entered name musted';
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  TextButton(onPressed: ()async{
                    Map? data = await Navigator.push(context,MaterialPageRoute(builder: (_)=>ManageCustomer(appBar: AppBar(title: const Text("Select Customer"),backgroundColor: appbar,),)));
                    if(data!=null){
                      customer=data['customer'];
                      userController.text = customer.name!;
                    }
                  },
                      child: IgnorePointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Select customer',
                            label: Text('Select Customer'),
                            border: OutlineInputBorder()
                          ),
                          controller: userController,
                        ),
                      ))

  ],
              ),
            ),
          ),
        ),
        bottomNavigationBar:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style:ElevatedButton.styleFrom(backgroundColor: Colors.grey,shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ),
                onPressed: (){
                  // User?user =FirebaseAuth.instance.currentUser;
                  // if(_formkey.currentState!.validate()){
                  //   customer.users!.forEach((element) {
                  //     FirebaseFirestore.instance.collection('customer').doc(user!.uid).set(customer.customerToJson());
                  //   });
                  // }
                },
                child: Text('Save')),
            SizedBox(width: 25,),
            ElevatedButton(
                style:ElevatedButton.styleFrom(backgroundColor: Colors.grey,shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ),
                onPressed: (){
                },
                child: Text('Clear'))
          ],
        )
    );
  }
}

