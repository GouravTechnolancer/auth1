import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey =GlobalKey<FormState>();
  String email = '';
  String password = '';
  String name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter Full Name',
                    border: OutlineInputBorder(),
                    label: Text('Name')
                  ),
                  onChanged: (value){
                   setState(() {
                     name=value;
                   });
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter your full name";
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Enter your Email',
                      label: Text('Email'),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value){
                    setState(() {
                      email=value;
                    });
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter your email correct";
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Enter Password',
                      label: Text('Password'),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value){
                    setState(() {
                      password=value;
                    });
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
                SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate())
                        {
                            FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: email,
                                password: password).then((value) => {

                            });
                        }
                    },
                    child: Text('signup')
                )


              ],
            ),
          ),
        ),
      ),
    );
  }
}
