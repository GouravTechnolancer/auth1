import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Warning extends StatefulWidget {
  const Warning({super.key});

  @override
  State<Warning> createState() => _WarningState();
}

class _WarningState extends State<Warning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage('assets/icons8-box-important.gif')),
          Text('You are not verified user! ',style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Contact :-',style: TextStyle(fontWeight: FontWeight.bold),),
              Text('9999988888',style: TextStyle(color: Colors.blue),),
              Text('/',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              Text('98888845454',style: TextStyle(color: Colors.blue),)
            ],
          ),
          SizedBox(height: 20,),
          ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Colors.grey,),onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, 'chooseAuthMethod');
          }, child: Text('logout'))
        ],
      ),
    );
  }
}
