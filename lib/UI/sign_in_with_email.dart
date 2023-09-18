import 'package:flutter/material.dart';

class SignInWithEmail extends StatefulWidget {
  const SignInWithEmail({super.key});

  @override
  State<SignInWithEmail> createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SignIn'),),
      body:Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter Your Email",
                label: Text("Email"),
                border: OutlineInputBorder()
              ),

            ),
            const SizedBox(height: 10,),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: "Enter Your Password",
                  label: Text("Password"),
                  border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: (){}, child: const Text('Login')),
            OutlinedButton(
                onPressed: (){
                  Navigator.pushNamed(context, 'registerUser');
                },
                child: const Text('SignUp'))

          ],
        ),
      )
    );
  }
}
