import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import '../Model/employee.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {

  final _formKey =GlobalKey<FormState>();
  Employee employee = Employee();

  @override
  Widget build(BuildContext context) {
    ProgressDialog pd = ProgressDialog(context: context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register User'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: employee.name,
                decoration: const InputDecoration(
                  hintText: 'Enter Full Name',
                  border: OutlineInputBorder(),
                  label: Text('Name')
                ),
                onChanged: ((val) => employee.name = val),
                validator: ((val) => val!.isEmpty ? "Enter Valid Name" : null),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                initialValue: employee.name,
                decoration: const InputDecoration(
                    hintText: 'Enter your contact',
                    border: OutlineInputBorder(),
                    label: Text('Phone ')
                ),
                onChanged: ((val) => employee.name = val),
                validator: ((val) => val!.isEmpty ? "Enter Valid Name" : null),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Enter your Email',
                    label: Text('Email'),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value){
                    employee.email=value;
                },
                validator: (value){
                  if(value!.isEmpty){
                    return "Enter your email correct";
                  }else{
                    return null;
                  }
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: 'Enter Password',
                    label: Text('Password'),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value){
                    employee.password=value;
                },
                validator: (value){
                  if(value!.isEmpty){
                    return "Password cannot be empty";
                  }if (!value.contains(RegExp(r'[A-Z]'))) {
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('The password must contain at least one uppercase letter')));
                    return 'The password must contain at least one uppercase letter.';
                  }
                  if (!value.contains(RegExp(r'[a-z]'))) {
                    return 'The password must contain at least one lowercase letter.';
                  }
                  if (!value.contains(RegExp(r'[0-9]'))) {
                    return 'The password must contain at least one number.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: ()async{
                    if(_formKey.currentState!.validate())
                      {
                        pd.show(msg: "please wait ",backgroundColor: Colors.green.shade600, );
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: employee.email!,
                              password: employee.password!).then((value)async {
                                User? user = FirebaseAuth.instance.currentUser;
                                 await FirebaseFirestore.instance.collection("user").doc(user!.uid).set(employee.toJson());
                                 pd.close();
                                 if(mounted)Navigator.pushNamed(context, "home");

                          });
                      }
                  },
                  child: const Text('signup')
              )


            ],
          ),
        ),
      ),
    );
  }
}
