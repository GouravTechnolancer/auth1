
import 'package:auth/pages/login_page.dart';
import 'package:auth/pages/signup_page.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    home:Home(),
    initialRoute: 'signup_page',
    routes: {
      'login_page': (context)=>LoginPage(),
      'signup_page': (context)=>SignupPage()
    },
  ));
}
class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authication'),
      ),
    );
  }
}

