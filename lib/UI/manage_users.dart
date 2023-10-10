import 'dart:async';
import 'package:auth/Model/employee.dart';
import 'package:auth/variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManageUsers extends StatefulWidget {
  final AppBar? appBar;
  const ManageUsers({super.key, this.appBar});

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  late StreamSubscription employeeListener;
  List<UserProfile>? allUsers = [];
  bool? checked;
  void getData(){
    // Get all data from firestore -- >Query(Firebase)
    Query query = FirebaseFirestore.instance.collection('user');
    employeeListener = query.snapshots().listen((QuerySnapshot snapshot) {
      if(snapshot.docs.isEmpty){
        allUsers = null;
      }else{
         allUsers = [];
         for(DocumentSnapshot documentSnapshot in snapshot.docs){
           UserProfile userProfile = UserProfile.fromMap(documentSnapshot.id, documentSnapshot.data() as Map<String, dynamic>);
           allUsers!.add(userProfile);
         }
      }
      if(mounted)setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar ?? AppBar(title: const Text('Manage Users'),backgroundColor: appbar,),
      body: allUsers == null ?  const Center(child: Text("No User Data Found"),) : allUsers!.isEmpty ? const Center(child: CircularProgressIndicator(),) :
      ListView.builder(
          itemCount : allUsers!.length ,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: ListTile(
                  title: Center(child: Text(allUsers![index].name.toString() ,style: const TextStyle(fontWeight: FontWeight.bold),)),
                  subtitle: Center(child: Text(allUsers![index].phoneNumber.toString() ,style: const TextStyle(fontWeight: FontWeight.bold),)),
                  onTap: (){
                    Navigator.pop(context,{
                     'user' : allUsers![index]
                    });
                  },
                )
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

