import 'dart:async';

import 'package:auth/Model/employee.dart';
import 'package:auth/UI/menu.dart';
import 'package:auth/UI/profile.dart';
import 'package:auth/variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late UserProfile employee;
  late StreamSubscription employeeListner;
  final List<Widget> _screen =[
    const Center(child: Text('Dashboard'),),
    const Menu(),
    const Profile()
  ];
  // void checkVerified()async{
  //   User?user =FirebaseAuth.instance.currentUser;
  //   DocumentReference reference = FirebaseFirestore.instance.collection("user").doc(user!.uid);
  //   employeeListner = reference.snapshots().listen((DocumentSnapshot snapshot) {
  //     if(snapshot.exists){
  //       employee = UserProfile.fromMap(snapshot.id, snapshot.data() as Map<String, dynamic>);
  //       if(employee.isVerified == false){
  //           Future.delayed(Duration(seconds: 2),(){
  //             Navigator.pushReplacementNamed(context, 'warning');
  //           });
  //       }
  //     }
  //   });
  // }

  int _currentIndex =0;
  @override
  // void initState() {
  //   // TODO: implement initState
  //   // checkVerified();
  // }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: _screen[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: appbar,
        elevation: 0,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard),label: 'Dashboard',),
          BottomNavigationBarItem(icon: Icon(Icons.menu),label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: 'Profile')
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      // bottomNavigationBar: Container(
      //   // color: Colors.black,
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
      //     child: GNav(
      //       // backgroundColor: Colors.black,
      //       selectedIndex: _currentIndex,
      //       padding: EdgeInsets.all(10),
      //       tabs: [
      //         GButton(icon: Icons.dashboard,text: 'Dashboard',),
      //         GButton(icon: Icons.menu,text: 'Menu',),
      //         GButton(icon: Icons.person,text: 'Profile',),
      //       ],
      //       onTabChange: (index){
      //         setState(() {
      //           _currentIndex = index;
      //           print(_currentIndex);
      //         });
      //       },
      //     ),
      //   ),
      // ),
    );

  }


}


