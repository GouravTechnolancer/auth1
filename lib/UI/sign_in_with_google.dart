import 'package:auth/Model/employee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SignInWithGoogle extends StatefulWidget {
  const SignInWithGoogle({super.key});

  @override
  State<SignInWithGoogle> createState() => _SignInWithGoogleState();
}
Employee employee =Employee();
class _SignInWithGoogleState extends State<SignInWithGoogle> {
  Map data={};
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map;
    print(data);
    return Scaffold(
      appBar: AppBar(title: const Text('Register'),),
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Name'),
              ),
              onChanged: (value){
                employee.name=value;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: '${data['email']}',
                border: const OutlineInputBorder()
              ),

              onChanged: (value){
                employee.email=value;
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: ()async{
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: employee.email!,
                  password: employee.password!
              ).then((value)async {
                User? user = FirebaseAuth.instance.currentUser;
                await FirebaseFirestore.instance.collection("user").doc(user!.uid).set(employee.toJson());
                print(employee.email);

              });
            }, child: const Text("Registerd"))
          ],
        ),
      )
    );
  }
}
