import 'package:auth/firebase_options.dart';
import 'package:auth/UI/sign_in_with_google.dart';
import 'package:auth/UI/home.dart';
import 'package:auth/UI/otp_verification.dart';
import 'package:auth/UI/sign_in_with_phone.dart';
import 'package:auth/UI/sign_in_with_email.dart';
import 'package:auth/UI/register_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'UI/choose_auth_method.dart';
import 'UI/profile.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform
  );
  runApp(MaterialApp(
    home:const Splash(),
    initialRoute: 'profile',
    routes: {
      'chooseAuthMethod':(context)=>const ChooseAuthMethod(),
      'registerUser': (context)=> const RegisterUser(),
      'signInWithEmail':(context)=>const SignInWithEmail(),
      'signInWithPhone':(context)=>const SignInWithPhone(),
      'otpVerification':(context) =>const OtpVerification(),
      'home':(context)=> const Home(),
      'signInWithGoogle':(context)=> const SignInWithGoogle(),
      'profile':(context) =>Profile()
    },
  ));
}
class Splash extends StatefulWidget {
  const Splash({super.key});


  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  void navigate()async{
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context, 'chooseAuthMethod');
    });

  }
  @override
  void initState() {
    super.initState();
    navigate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
      ),
      body:Center(
        child: CircularProgressIndicator (
          color: Colors.red[900],
        ),
      )

    );
  }
}

