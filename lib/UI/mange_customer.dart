import 'package:auth/Model/customer.dart';
import 'package:auth/variable.dart';
import 'package:flutter/material.dart';

class ManageCustomer extends StatefulWidget {
  const ManageCustomer({super.key});

  @override
  State<ManageCustomer> createState() => _ManageCustomerState();
}

class _ManageCustomerState extends State<ManageCustomer> {
  Map? data = {};
  Customer customer = Customer();

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map?;
    customer = data?["customer"] ?? Customer();
    return Scaffold(
        appBar: AppBar(title: const Text('Mange customer'),backgroundColor: appbar,),
        body:const Column(

        ),
      floatingActionButton: FloatingActionButton(onPressed: (){
           Navigator.pushNamed(context, 'addCustomers');
          },backgroundColor: appbar,child: const Icon(Icons.add),)

    );
  }
}







