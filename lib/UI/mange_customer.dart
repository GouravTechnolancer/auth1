import 'dart:async';

import 'package:auth/Model/customer.dart';
import 'package:auth/variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ManageCustomer extends StatefulWidget {
  const ManageCustomer({super.key});

  @override
  State<ManageCustomer> createState() => _ManageCustomerState();
}

class _ManageCustomerState extends State<ManageCustomer> {
  Map? data = {};
  List<Customer> allCustomer = [];
  late StreamSubscription employeeListner;
  Customer customer = Customer();
  void customerdata(){
    User? user = FirebaseAuth.instance.currentUser;
    DocumentReference reference = FirebaseFirestore.instance.collection("customer").doc(user!.uid);
    employeeListner = reference.snapshots().listen((DocumentSnapshot snapshot) {
      if(snapshot.exists){
        customer = Customer.fromMap(snapshot.id, snapshot.data() as Map<String, dynamic>);
        allCustomer.add(customer);
        setState(() {

        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    customerdata();
  }
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map?;
    customer = data?["customer"] ?? Customer();
    return Scaffold(
        appBar: AppBar(title: const Text('Mange customer'),backgroundColor: appbar,),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: allCustomer.length ==null ? Text('') :
          ListView.builder(itemCount: allCustomer.length,itemBuilder: (context,index){
            return ListTile(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.grey,width: 4)),
              leading: Text('${index+1}'),
              title: Column(
                children: [
                  Text('Name',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  Text(allCustomer[index].name!),
                ],
              ),
              trailing: Column(
                children: [
                  SizedBox(height: 10,),
                  Text('GstNo',style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 5,),
                  Text(allCustomer[index].gstno!)
                ],
              ),
              onTap: (){},
            );
          }),
        ),
      floatingActionButton: FloatingActionButton(onPressed: (){
           Navigator.pushNamed(context, 'addCustomers');
          },backgroundColor: appbar,child: const Icon(Icons.add),)

    );
  }
}







