import 'package:auth/firebase_options.dart';
import 'package:auth/pages/otp.dart';
import 'package:auth/pages/phone.dart';
import 'package:auth/pages/signin.dart';
import 'package:auth/pages/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'lists/listofauth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform
  );
  runApp(MaterialApp(
    home:Home(),
    initialRoute: 'signup_page',
    routes: {
      'listofauth':(context)=>ListOfAuth(),
      'signup_page': (context)=>SignupPage(),
      'signin':(context)=>SignIn(),
      'phone':(context)=>Phone(),
      'otp':(context) =>Otp()
    },
  ));
}
class Home extends StatefulWidget {


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void Navto()async{
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushNamed(context, 'listofauth');
    });

  }
  @override
  void initState() {
    super.initState();
    Navto();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authication'),
      ),
      body:Center(
        child: CircularProgressIndicator (
          color: Colors.red[900],

        ),
      )

    );
  }
}

