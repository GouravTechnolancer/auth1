import 'dart:async';
import 'package:auth/UI/home.dart';
import 'package:auth/UI/profile.dart';
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
  Widget build(BuildContext context) => isEmailVerified ? Home() : Scaffold(appBar: AppBar(title: Text('verify Email'),),);
}
