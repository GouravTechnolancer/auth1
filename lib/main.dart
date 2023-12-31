import 'package:auth/Model/employee.dart';
import 'package:auth/UI/mange_customer.dart';
import 'package:auth/UI/home.dart';
import 'package:auth/UI/add_customer.dart';
import 'package:auth/UI/manage_users.dart';
import 'package:auth/UI/warning.dart';
import 'package:auth/app_theme.dart';
import 'package:auth/firebase_options.dart';
import 'package:auth/UI/sign_in_with_google.dart';
import 'package:auth/UI/work_hub_logo.dart';
import 'package:auth/UI/otp_verification.dart';
import 'package:auth/UI/sign_in_with_phone.dart';
import 'package:auth/UI/register_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:provider/provider.dart';
import 'UI/Email verification.dart';
import 'UI/choose_auth_method.dart';
import 'UI/profile.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform
  );
  runApp(ChangeNotifierProvider(
    create: (context) => AppTheme(),
    child: Consumer<AppTheme>(
      builder: (context , state,child){
        return  MaterialApp(
          debugShowCheckedModeBanner: false,
          home:const Splash(),
          initialRoute: 'splash',
          routes: {
            // 'myapp':(context) => MyApp(),
            'chooseAuthMethod':(context)=>const ChooseAuthMethod(),
            'registerUser': (context)=> const RegisterUser(),
            'signInWithPhone':(context)=>const SignInWithPhone(),
            'otpVerification':(context) =>const OtpVerification(),
            'workhublogo':(context)=> const WorkHubLogo(),
            'signInWithGoogle':(context)=> const SignInWithGoogle(),
            'profile':(context) =>const Profile(),
            'splash':(context)=> const Splash(),
            'home' : (context) => const Home(),
            'manageUsers' : (context) => const ManageUsers(),
            'warning' : (context) =>const Warning(),
            'manageCustomer' : (context) => const ManageCustomer(),
            'addCustomers' : (context) =>const AddCustomers(),
            'verifyEmail' : (context) =>const VerifyEmail(),
          },
        );
      },

    ),
  ));
}
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  void chooseAuth()async {
    Future.delayed(Duration(seconds: 3), () async {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        String uid = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance.collection("user").doc(uid)
            .get()
            .then((DocumentSnapshot snapshot) {
          if (snapshot.exists) {
            UserProfile employee = UserProfile.fromMap(
                snapshot.id, snapshot.data() as Map<String, dynamic>);
            print(employee);
            if (employee.isVerified == null || !employee.isVerified!) {
              Navigator.pushNamed(context, 'warning');
            } else {
              Navigator.pushReplacementNamed(context, 'home');
            }
          } else {
            Navigator.pushNamed(context, 'chooseAuthMethod',
                arguments: {'showPasswordField': true});
          }
        });
      } else {
        Navigator.pushNamed(context, 'chooseAuthMethod');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    chooseAuth();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Column(
         mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              border:Border.all(width: 4,color:Colors.black54)
            ),
            child: const Image(image: AssetImage('assets/work.png'),width: 250,height: 300,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height:400),
              Center(
                child: JumpingDots(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const Text('Powered by Technolancer',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),




        ],
      )

    );
  }
}
