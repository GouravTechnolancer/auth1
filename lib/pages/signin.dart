import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SignIn '),),
      body:Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter Your Email",
                label: Text("Email"),
                border: OutlineInputBorder()
              ),

            ),
            SizedBox(height: 10,),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Enter Your Password",
                  label: Text("Password"),
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){}, child: Text('Login')),
            OutlinedButton(
                onPressed: (){
                  Navigator.pushNamed(context, 'signup_page');
                },
                child: Text('SignUp'))

          ],
        ),
      )
    );
  }
}
