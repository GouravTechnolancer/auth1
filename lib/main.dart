import 'package:auth/firebase_options.dart';
import 'package:auth/UI/sign_in_with_google.dart';
import 'package:auth/UI/home.dart';
import 'package:auth/UI/otp_verification.dart';
import 'package:auth/UI/sign_in_with_phone.dart';
import 'package:auth/UI/sign_in_with_email.dart';
import 'package:auth/UI/register_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'UI/choose_auth_method.dart';
import 'UI/profile.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform
  );
  runApp(MaterialApp(
    home:const Splash(),
    initialRoute: 'home',
    routes: {
      'chooseAuthMethod':(context)=>const ChooseAuthMethod(),
      'registerUser': (context)=> const RegisterUser(),
      'signInWithEmail':(context)=>const SignInWithEmail(),
      'signInWithPhone':(context)=>const SignInWithPhone(),
      'otpVerification':(context) =>const OtpVerification(),
      'home':(context)=> const Home(),
      'signInWithGoogle':(context)=> const SignInWithGoogle(),
      'profile':(context) =>Profile(),
      'splash':(context)=> Splash()
    },
  ));
}
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  void choose_auth()async{
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, 'chooseAuthMethod');
    });

  }
  @override
  void initState() {
    super.initState();
    // choose_auth();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          SizedBox(height: 180,),
          Center(
            child: Container(
              width:180,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2
                  )
                ]
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height:400),
              Center(
                child: JumpingDots(
                  color: Colors.black54,
                ),
              ),

            ],
          ),
          Text('Powered by Technolancer',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),




        ],
      )

    );
  }
}
