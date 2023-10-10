import 'dart:async';
import 'package:auth/UI/home.dart';
import 'package:auth/UI/profile.dart';
import 'package:auth/variable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  Timer? timer;
  // ignore: must_call_super
  @override
  void initState() {
    // TODO: implement initState
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if(!isEmailVerified){
      sendVerificationEmail();
      timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailverified());
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }
  Future checkEmailverified()async{
    await FirebaseAuth . instance.currentUser!.reload();
    setState(() {
      isEmailVerified=FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isEmailVerified) timer ?.cancel();
  }
  Future sendVerificationEmail()async{
    final user = FirebaseAuth.instance.currentUser;
    await user!.sendEmailVerification();
    print('send verification code');
  }
  @override
  Widget build(BuildContext context) => isEmailVerified ? Home() :
  Scaffold(
    appBar: AppBar(
      title: Text('verify Email'),
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: appbar,
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Image(image: NetworkImage('https://img.freepik.com/free-vector/two-factor-authentication-concept-'
                'illustration_114360-5598.jpg?w=826&t=st=1696928130~exp=1696928730~hmac=8a9d153106bdd18914b4036aa5d40a23e3ee5a5e59708a9649844d0f14bc0f69'),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Check your Gmail for Verification',style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(width: 5,),
                Icon(Icons.mark_email_unread,color: Colors.orange,)
              ],
            ),

        ],
      ),
    ),
  );
}
