import 'dart:ui';
import 'package:auth/Model/customer.dart';
import 'package:auth/Model/employee.dart';
import 'package:auth/UI/manage_users.dart';
import 'package:auth/variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class AddCustomers extends StatefulWidget {
  const AddCustomers({super.key});

  @override
  State<AddCustomers> createState() => _AddCustomersState();
}

class _AddCustomersState extends State<AddCustomers> {
  late UserProfile userProfile;
  TextEditingController userController = TextEditingController();
  Customer customer =Customer(users: []);
  final _formkey =GlobalKey<FormState>();

  Future showDialogBox(int index){

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Column(
            children: [
              SizedBox(height: 4,),
              TextFormField(
                enabled: false,
                decoration: InputDecoration(
                    hintText: '',
                    label: Text('S.No'),
                    border: OutlineInputBorder()
                ),
                initialValue: (index+1).toString(),
              ),
              TextButton(onPressed: () async {
                // Navigator.pushNamed(context, 'manageUsers');
                Map? data = await Navigator.push(context,MaterialPageRoute(builder: (_)=>ManageUsers(appBar: AppBar(title: const Text("Select User"),backgroundColor: appbar,),)));
                if(data != null){
                  userProfile = data['user'];
                  userController.text = userProfile.name!;
                }
              },
                child:IgnorePointer(
                  child: TextFormField(style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      label: Text('User'),
                      hintText: 'User',
                      border: OutlineInputBorder(),
                    ),
                    controller: userController,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if(customer.users!.where((element) => element.id == userProfile.id).toList().isNotEmpty){

                }else{
                  customer.users!.add(userProfile);
                }
                // for(int i=0;i<customer.users!.length;i++){
                //   if(customer.users![i].id ==userProfile.id){
                //     exist = true;
                //   }
                // }
                // if(!exist) {
                //   customer.users!.add(userProfile);
                // }
                setState(() {
                  userController.text='';
                });
                print(customer.users);
                Navigator.pop(context);

              },
              child: Text('ADD'),
            ),
          ],
        );
      },
    );
 }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text('Customer details'),centerTitle: true,backgroundColor: appbar,),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(style: const TextStyle(fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                      label: Text('Name'),
                      hintText: 'Enter Name',
                      border: OutlineInputBorder(),
                      suffix: Icon(Icons.person)
                  ),
                  onChanged: (value){
                    customer.name = value;
                  },
                  validator: (val){
                    if(val!.isEmpty)  return 'Entered name musted';
                    return null;
                  },
                ),const SizedBox(height: 10,),
                TextFormField(style: const TextStyle(fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                      label: Text('Gst No'),
                      hintText: 'Enter Gst.No',
                      border: OutlineInputBorder(),
                      suffix: Icon(Icons.app_registration)
                  ),
                  onChanged: (value){
                    customer.gstno = value;
                  },
                  validator: (val){
                    if(val!.isEmpty)  return 'Entered Gstno must';
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                // TextButton(onPressed: () async {
                //         // Navigator.pushNamed(context, 'manageUsers');
                //     Map? data = await Navigator.push(context,MaterialPageRoute(builder: (_)=>ManageUsers(
                //         appBar: AppBar(title: const Text("Select User"),backgroundColor: appbar,),
                //         )));
                //     if(data != null){
                //       List<UserProfile> selectedUser = data['selectedUser'];
                //       print(selectedUser);
                //     }
                //     },
                //     child:IgnorePointer(
                //       child: TextFormField(style: const TextStyle(fontWeight: FontWeight.bold),
                //         decoration: const InputDecoration(
                //             label: Text('User'),
                //             hintText: 'User',
                //             border: OutlineInputBorder(),
                //         ),
                //       ),
                //     ),
                // ),
               SizedBox(
                 height: height *0.40,
                 child: Card(
                   elevation: 10,
                   color: Colors.transparent,
                   child: Container(
                     decoration: BoxDecoration(
                       color: Colors.grey,
                       borderRadius: BorderRadius.circular(10),
                     ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             CircleAvatar(child: Icon(Icons.dashboard,color: Colors.black,),backgroundColor: Colors.white,),
                             SizedBox(width: 5,),
                             Text('Users'),
                             SizedBox(width: 120,),
                             ElevatedButton(style:ElevatedButton.styleFrom(
                               backgroundColor: Colors.white,
                               side: BorderSide(style: BorderStyle.solid)
                             ),
                                 onPressed: (){
                                   showDialogBox(customer.users!.length);
                                 },
                                 child: Text('ADD',style: TextStyle(color: Colors.black),)),
                           ],
                         ),
                          Divider(thickness: 2,color: Colors.white,),
                          Expanded(
                            child: customer.users!.isEmpty ?Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 25,),
                                CircleAvatar(radius: 30,child: Icon(Icons.dataset,color: Colors.black,),backgroundColor: Colors.white,),
                                SizedBox(height: 25,),
                                Text('No User Added !!',style: TextStyle(fontWeight: FontWeight.bold), )
                              ],
                            ): ListView.builder(itemCount:customer.users!.length,itemBuilder: (context,index){
                              return Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                child: ListTile(
                                  leading: Text('${index+1}'),
                                  title: Text('Name :'' ${customer.users![index].name!}',maxLines: 1,overflow: TextOverflow.ellipsis),
                                  trailing: CircleAvatar(
                                    backgroundColor: Colors.transparent,foregroundColor: Colors.black,
                                    child: IconButton(
                                      onPressed: (){
                                        User?user = FirebaseAuth.instance.currentUser;
                                        customer.users!.removeWhere((element) => element.id == customer.users![index].id);
                                        setState(() {

                                        });
                                        print(customer.users!.length);
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                  ),
                                )
                                ,
                              );
                            })
                          ),

                        ],
                      ),
                    ),
                   ),
                 ),
               ),
                ElevatedButton(
                    style:ElevatedButton.styleFrom(backgroundColor: Colors.grey,shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)) ),
                    onPressed: (){
                      User?user =FirebaseAuth.instance.currentUser;
                      if(_formkey.currentState!.validate()){
                        customer.users!.forEach((element) {
                          FirebaseFirestore.instance.collection('customer').doc(user!.uid).set(customer.toJson());
                        });
                      }
                    },
                    child: Text('Save'))
              ],
            ),
          ),
        ),
      ),

    );
  }
}
