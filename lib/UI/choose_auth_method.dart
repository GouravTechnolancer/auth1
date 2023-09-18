import 'package:auth/Model/employee.dart';
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
      appBar: AppBar(title: const Text('Choose Sign In Method'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.mail,size: 45),
              OutlinedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, "signInWithEmail");
                  },
                  child: const Text('Email Login'))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.phone,size: 45),
              OutlinedButton(
                  onPressed: (){
                   Navigator.pushNamed(context, "signInWithPhone");
                  },
                  child: const Text('Phone Login'))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.manage_accounts,size: 45),
              OutlinedButton(
                  onPressed: (){
                    pd.show(msg:'Login in');
                    signInWithGoogle();
                  },
                  child: const Text('Google Login'))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.account_circle,size: 45),
              OutlinedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, "routeName");
                  },
                  child: const Text('Profile'))
            ],
          ),

        ],
      ),
    );
  }
}
