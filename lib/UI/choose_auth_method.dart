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
  UserProfile employee = UserProfile(image: null);
  String? email;
  String? password;
  final _formKey = GlobalKey<FormState>();
  bool obsure =true;
  String? error = "";

  @override
  Widget build(BuildContext context) {

    ProgressDialog pd = ProgressDialog(context: context);
    //Google Signin Method
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
          Navigator.pushNamed(context, "registerUser",arguments: {
            'image':user.photoURL,
            'name':user.displayName,
            'email':user.email,
            'showPasswordField': false,
          });
        }
        else{
          Navigator.pushNamed(context, "home");
        }
      });
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Sign In Method'),backgroundColor:appbar,centerTitle: true,elevation: 0,),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // FirebaseFirestore.instance.collection('user').doc(uid!).get(DocumentSnapshot),
              const SizedBox(height: 40,),
              const Image(image: AssetImage('assets/work.png'),width: 220,fit: BoxFit.cover),
              const SizedBox(height: 30,),
              SizedBox(
                width: 350,
                child: TextFormField(
                  decoration: const InputDecoration(
                      suffixIcon:Icon(Icons.mail,color: Colors.black,),
                      border: OutlineInputBorder(),
                      hintText: 'Email address',
                  ),
                  onChanged: (value){
                    email=value;
                  },
                    validator: (val){
                      if(val == null)return 'Enter Email';
                      return null;
                    }
                ),
              ),
              const SizedBox(height: 4,),
              SizedBox(
                width: 350,
                child: TextFormField(
                  obscureText: obsure,
                    decoration: InputDecoration(
                      suffixIcon:IconButton(icon:const Icon(Icons.remove_red_eye,color: Colors.black,),onPressed:(){
                        setState(() {
                          obsure = !obsure;
                        });
                      } ),
                      border: const OutlineInputBorder(),
                      hintText: 'Password',
                  ),
                  onChanged: (value){
                    password=value;
                  },
                  validator: (val){
                    if(val == null)return 'Enter password';
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10,),
              error == null ? const Text(""):Text('$error',style: const TextStyle(color: Colors.red),),
              SizedBox(
                width: 350,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff7d7676)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        pd.show(msg: "Please Wait...");
                        try {
                          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);
                          // await FirebaseFirestore.instance.collection("user").doc(user.uid).get().then((DocumentSnapshot snapshot) {
                          //   employee = UserProfile.fromMap(snapshot.id, snapshot.data() as Map<String,dynamic>);
                          // });
                          pd.close();
                          if (mounted) {
                            Navigator.pushReplacementNamed(context, "home");
                          }
                        }on FirebaseAuthException catch (e) {
                          pd.close();
                          if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
                            setState(() {
                              error = "INVALID LOGIN CREDENTIALS";
                            });
                          } else if (e.code == 'wrong-password') {
                            setState(() {
                              error = "Wrong Password";
                            });
                          } else{
                            setState(() {
                              error = "Something Went Wrong";
                            });
                          }
                        }
                      }
                    },
                    child: const Text('Login',style: TextStyle(color: Colors.white),)),
              ),

              const SizedBox(height: 10,),
              SizedBox(
                width: 350,
                child: Row(
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(onTap:(){
                      Navigator.pushNamed(context, 'registerUser',arguments: {
                        'showPasswordField': true
                      });
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
                   width: 250,
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
                    width: 250,
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
                    width: 250,
                    child: OutlinedButton(onPressed:(){
                      signInWithGoogle();
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
                    width: 250,
                    child: OutlinedButton(onPressed: (){}, child: const Row(
                      children: [
                        Image(image: AssetImage('assets/microsoft.png') ,height: 20,),
                        SizedBox(width: 10,),
                        Text('Sign in With Email ',overflow: TextOverflow.ellipsis,)
                      ],)),
                  )
                ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(backgroundColor: Colors.grey),
                        onPressed: (){}, child: const Row(
                      children: [
                        Image(image: AssetImage('assets/github.png') ,height: 20,),
                        SizedBox(width: 10,),
                        Text('Sign in With GitHib ',overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),)
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
