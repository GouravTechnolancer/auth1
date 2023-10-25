import 'dart:async';

import 'package:auth/Model/customer.dart';
import 'package:auth/variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ManageCustomer extends StatefulWidget {
  final AppBar? appBar;
  const ManageCustomer({super.key, this.appBar});

  @override
  State<ManageCustomer> createState() => _ManageCustomerState();
}

class _ManageCustomerState extends State<ManageCustomer> {
  Map? data = {};
  List<Customer> allCustomer = [];
  late StreamSubscription employeeListner;
  Customer customer = Customer();
  void customerdata()async{
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
        appBar: widget.appBar ?? AppBar(title: const Text('ManageCustomer'),backgroundColor: appbar,),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: allCustomer.length ==null ? Text('') :
          ListView.builder(itemCount: allCustomer.length,itemBuilder: (context,index){
            return ListTile(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.grey,width: 4)),
              leading: Text('${index+1}'),
              title: Column(
                children: [
                  Row(
                    children: [
                      Text('Name:-',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      Text(allCustomer[index].name!),
                    ],
                  ),
                  Row(
                    children: [
                      Text('GstNo:-',style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(allCustomer[index].gstno!)
                    ],
                  ),
                ],

              ),
              onLongPress: (){
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Edit'),
                    content: Text('If u want to edit customer detail'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Save the edited item.
                          Navigator.pushNamed(context, 'addCustomers',arguments: {
                              'allcustomer':allCustomer
                          });
                        },
                        child: Text('Edit'),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      floatingActionButton: FloatingActionButton(onPressed: (){
           Navigator.pushNamed(context, 'addCustomers');
          },backgroundColor: appbar,child: const Icon(Icons.add),)

    );
  }
}







