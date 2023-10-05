import 'dart:async';

import 'package:auth/Model/employee.dart';
import 'package:auth/variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key});

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  late StreamSubscription employeeListener;
  List<UserProfile>? users = [];

  void getData(){
    // Get all data from firestore -- >Query(Firebase)
    Query query = FirebaseFirestore.instance.collection('user');
    employeeListener = query.snapshots().listen((QuerySnapshot snapshot) {
      if(snapshot.docs.isEmpty){
        users = null;
      }else{
         users = [];
         for(DocumentSnapshot documentSnapshot in snapshot.docs){
           UserProfile userProfile = UserProfile.fromMap(documentSnapshot.id, documentSnapshot.data() as Map<String, dynamic>);
           users!.add(userProfile);
         }
      }
      if(mounted)setState(() {});
    });
    // Query query =FirebaseFirestore.instance.collection('user');
    // employeeListener =query.snapshots().listen((QuerySnapshot snapshot) {
    //   if(snapshot.docs.isEmpty){
    //     users = null;
    //   }
    //   else{
    //     users=[];
    //     for(DocumentSnapshot documentSnapshot in snapshot.docs){
    //       UserProfile userProfile = UserProfile.fromMap(documentSnapshot.id, documentSnapshot.data() as Map<String,dynamic>);
    //       users!.add(userProfile);
    //     }
    //   }if(mounted)setState(() {
    //
    //   });
    // });

  }

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Users'),
        centerTitle: true,
        backgroundColor: appbar,
        elevation: 0,),
      body: users == null ?  const Center(child: Text("No User Data Found"),) : users!.isEmpty ? const Center(child: CircularProgressIndicator(),) :
      ListView.builder(
          itemCount : users!.length ,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: ListTile(
                  title: Center(child: Text(users![index].name!, style: const TextStyle(fontWeight: FontWeight.bold),)),
                  subtitle: Center(child: Text(users![index].phoneNumber!)),
                ),
              ),
            );
      }),
      // body: ListView.separated(padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),itemBuilder: (context,index){
      //   return Center(child: Text(arrayName[index]));
      // }, separatorBuilder: (context,index){
      //    return const Divider(
      //      thickness: 2,
      //      height: 30,
      //    );
      // }, itemCount: arrayName.length),
        floatingActionButton: FloatingActionButton(backgroundColor: appbar,onPressed: (){},child:const Icon(Icons.add,) ,)
    );
  }
}

