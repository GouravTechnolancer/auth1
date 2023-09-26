import 'package:auth/Model/employee.dart';
import 'package:auth/variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';
class ChooseAuthMethod extends StatefulWidget {
  const ChooseAuthMethod({super.key});

  @override
  State<ChooseAuthMethod> createState() => _ChooseAuthMethodState();
}

class _ChooseAuthMethodState extends State<ChooseAuthMethod> {
  Employee employee = Employee();
  String? email;
  String? password;
  final _formKey = GlobalKey<FormState>();

  String? error;
  @override
  Widget build(BuildContext context) {

    ProgressDialog pd = ProgressDialog(context: context);

    Future signInWithGoogle()async{
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth =await googleUser?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken:googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = FirebaseAuth.instance.currentUser;
      // await FirebaseFirestore.instance.collection("user").doc(user!.uid).set(employee.toJson());
      // print('succefully submited');

      await FirebaseFirestore.instance.collection("user").doc(user!.uid).get().then((DocumentSnapshot snapshot){
        if(!snapshot.exists){
          pd.close();
          Navigator.pushNamed(context, "signInWithGoogle",arguments: {
            'email':user.email,
          });
        }
        else{
          Navigator.pushNamed(context, "signInWithEmail");
        }
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Choose Sign In Method'),backgroundColor:appbar,centerTitle: true,elevation: 0,),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40,),
              const Image(image: AssetImage('assets/work.png'),width: 220,fit: BoxFit.cover),
              const SizedBox(height: 30,),
              SizedBox(
                width: 350,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email address',
                  ),
                  onChanged: (value){
                    email=value;
                  },
                ),
              ),
              const SizedBox(height: 4,),
              SizedBox(
                width: 350,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                  onChanged: (value){
                    password=value;
                  },
                ),
              ),
              const SizedBox(height: 10,),
              error == null ? Text(""):Text('${error}',style: TextStyle(color: Colors.red),),
              SizedBox(
                width: 350,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff7c7c7c)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        pd.show(msg: "Please Wait...");
                        try {
                          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);
                          pd.close();
                          if (mounted) {
                            Navigator.pushReplacementNamed(context, "profile");
                          }
                        }on FirebaseAuthException catch (e) {
                          pd.close();
                          if (e.code == 'user-not-found') {
                            // setState(() {
                            //   error = "Email Not Found";
                            // });
                          } else if (e.code == 'wrong-password') {
                            print("1");
                            // setState(() {
                            //   error = "Wrong Password";
                            // });
                          } else{
                            setState(() {
                              error = "Something Went Wrong";
                            });
                          }
                        }
                        print(error);
                      }
                    },
                    child: Text('Login')),

              ),

              const SizedBox(height: 10,),
              SizedBox(
                width: 350,
                child: Row(
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(onTap:(){
                      Navigator.pushNamed(context, 'registerUser');
                    },
                        child: const Text('Sign up',style: TextStyle(color: Colors.blue),))
                  ],
                ),
              ),
              const SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 SizedBox(
                   width: 220,
                   child: OutlinedButton(onPressed: (){}, child: const Row(
                     children: [
                       Image(image: AssetImage('assets/linkedin (1).png') ,height: 20,),
                       SizedBox(width: 10,),
                       Text('Sign in With LinkedIn ',overflow: TextOverflow.ellipsis,)
                     ],)),)
               ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 220,
                    child: OutlinedButton(onPressed: (){
                      Navigator.pushNamed(context, 'signInWithPhone');
                    }, child: const Row(
                      children: [
                        Image(image: AssetImage('assets/phone.png') ,height: 20,),
                        SizedBox(width: 10,),
                        Text('Sign in With Phone ')
                      ],)),)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 220,
                    child: OutlinedButton(onPressed: (){
                      Navigator.pushNamed(context, 'signInWithGoogle');
                    }, child: const Row(
                      children: [
                        Image(image: AssetImage('assets/google.png') ,height: 20,),
                        SizedBox(width: 10,),
                        Text('Sign in With Google ')
                      ],
                    )
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 220,
                    child: OutlinedButton(onPressed: (){}, child: const Row(
                      children: [
                        Image(image: AssetImage('assets/microsoft.png') ,height: 20,),
                        SizedBox(width: 10,),
                        Text('Sign in With Microsoft ',overflow: TextOverflow.ellipsis,)
                      ],)),)
                ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 220,
                    child: OutlinedButton(onPressed: (){}, child: const Row(
                      children: [
                        Image(image: AssetImage('assets/github.png') ,height: 20,),
                        SizedBox(width: 10,),
                        Text('Sign in With GitHib ',overflow: TextOverflow.ellipsis,)
                      ],)),)
                ],)
            ],
          ),
        ),
      ),
    );
  }
}
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
//     ElevatedButton.icon(onPressed: (){
//       Navigator.pushNamed(context, "signInWithEmail");
//     }, icon: const Icon(Icons.mail,size:35,),
//       label: const Text('signInWithEmail',style: TextStyle(fontSize: 17)),
//       style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff090909),shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20)
//       )),)
