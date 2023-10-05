import 'package:auth/Model/employee.dart';
import 'package:auth/variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SignInWithGoogle extends StatefulWidget {
  const SignInWithGoogle({super.key});

  @override
  State<SignInWithGoogle> createState() => _SignInWithGoogleState();
}

class _SignInWithGoogleState extends State<SignInWithGoogle> {
  Map data={};
  UserProfile employee =UserProfile(image: null);
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(title: const Text('Register'),backgroundColor: appbar),
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage('https://lh3.googleusercontent.com/a/ACg8ocI4ho4Q8MvUpVuBzW7ZXLBFwxaxGOgIwpK0GE7MbpMZ=s96-c'),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              readOnly: true,
              decoration:  InputDecoration(
                hintText: '${data['name']}',
                suffixIcon:const Icon(Icons.account_circle),
                border: const OutlineInputBorder(),

              ),
              onChanged: (value){
                employee.name=value;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                suffixIcon:Icon(Icons.phone),
                border: OutlineInputBorder(),
                label: Text('Phone'),
              ),
              onChanged: (value){
                employee.phoneNumber=value;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                  suffixIcon:const Icon(Icons.email,color: Colors.blue,),
                  hintText: '${data['email']}',
                  border: const OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor: const Color(0xff7c7c7c)),onPressed: ()async{
              employee.email = '${data['email']}';
              employee.name ='${data['name']}';
              employee.phoneNumber ='${data['phone']}';
                User? user = FirebaseAuth.instance.currentUser;
                await FirebaseFirestore.instance.collection("user").doc(user!.uid).set(employee.toJson());
            }, child: const Text("Registerd"))
          ],
        ),
      )
    );
  }
}
