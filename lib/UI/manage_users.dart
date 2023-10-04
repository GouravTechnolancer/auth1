import 'package:auth/variable.dart';
import 'package:flutter/material.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key});

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {

  List arrayName=['Gourav`','Depepak','Manav'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ManageUsers'),
        centerTitle: true,
        backgroundColor: appbar,
        elevation: 0,),
      body: ListView.separated(padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),itemBuilder: (context,index){
        return Center(child: Text(arrayName[index]));
      }, separatorBuilder: (context,index){
         return const Divider(
           thickness: 2,
           height: 30,
         );
      }, itemCount: arrayName.length),
        floatingActionButton: FloatingActionButton(backgroundColor: appbar,onPressed: (){},child:const Icon(Icons.add,) ,)
    );
  }
}

