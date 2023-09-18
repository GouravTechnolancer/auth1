import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title:Text('Profile',style: TextStyle(color: Colors.black),), centerTitle: true,elevation: 0,backgroundColor: Colors.white,),
      body:Column(
       children: [
         SizedBox(height: 20,),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Container(
               width: 100,
                 height: 100,
                 decoration: BoxDecoration(
                   color: Colors.black,
                   borderRadius: BorderRadius.circular(40)
                 ),
                 child: CircleAvatar(
                   backgroundColor: Colors.green.shade600,
                 )
             )
           ],
         ),
         ElevatedButton(onPressed: (){},
             child: Text('Edit Profile',style: TextStyle(color: Colors.black),)),
         Row(
           children: [
             Expanded(
               flex: 1,
               child: Container(color: Colors.black,
                 child: Text('Name',style: TextStyle(color: Colors.white),),
               ),
             ),
             SizedBox(width: 10,),
             Expanded(
               flex: 2,
               child: Container(
                   color: Colors.grey

               ),
             )
           ],
         ),
       ],

      )
    )
    );

  }
}
