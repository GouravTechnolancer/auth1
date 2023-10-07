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
  List<UserProfile > selectedUser =[];
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
    print(selectedUser);
    return Scaffold(
      appBar: widget.appBar == null ? AppBar(title: const Text('Manage Users'),backgroundColor: appbar,) : AppBar(title: const Text('Selected Users'),
        actions: [
          selectedUser.isNotEmpty? IconButton(onPressed: (){
            Navigator.pop(context,{'selectedUser':selectedUser});
          }, icon: const Icon(Icons.add)) :const Text('')
        ],
        centerTitle: true,
        backgroundColor: appbar,
        elevation: 0,),
      body: allUsers == null ?  const Center(child: Text("No User Data Found"),) : allUsers!.isEmpty ? const Center(child: CircularProgressIndicator(),) :
      ListView.builder(
          itemCount : allUsers!.length ,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: widget.appBar == null ? ListTile(
                  title: Center(child: Text(allUsers![index].name as String,style: const TextStyle(fontWeight: FontWeight.bold),)),
                  subtitle: Center(child: Text(allUsers![index].phoneNumber as String,style: const TextStyle(fontWeight: FontWeight.bold),)),
                ) : CheckboxListTile(
                  value: selectedUser.where((element) => element.id == allUsers![index].id).toList().isNotEmpty,
                  onChanged: (bool? value){
                    if(value == true){
                      setState(() {
                        selectedUser.add(allUsers![index]);
                      });
                    }
                    else{
                      setState(() {
                        selectedUser.removeWhere((element) => element.id == allUsers![index].id);
                      });
                    }
                  },
                  title: Center(child: Text(allUsers![index].name as String,style: const TextStyle(fontWeight: FontWeight.bold),)),
                  subtitle: Center(child: Text(allUsers![index].phoneNumber as String,style: const TextStyle(fontWeight: FontWeight.bold),)),

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

