import 'package:auth/UI/add_projects.dart';
import 'package:auth/variable.dart';
import 'package:flutter/material.dart';

class ManageProjects extends StatefulWidget {
  const ManageProjects({super.key});

  @override
  State<ManageProjects> createState() => _ManageProjectsState();
}

class _ManageProjectsState extends State<ManageProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Projects'),centerTitle: true,backgroundColor: appbar),
      body: Column(
        children: [

        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appbar,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_)=>AddProjects()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
