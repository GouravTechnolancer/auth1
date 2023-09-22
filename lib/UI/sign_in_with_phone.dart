import 'package:auth/variable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInWithPhone extends StatefulWidget {
  static String verify="";
  static String contact ="";
  const SignInWithPhone({super.key});

  @override
  State<SignInWithPhone> createState() => _SignInWithPhoneState();
}

class _SignInWithPhoneState extends State<SignInWithPhone> {
  TextEditingController countryCode =TextEditingController();
  var phone = "";
  @override
  void initState() {
    countryCode.text="+91";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone '),backgroundColor: appbar),
      body: Container(
        margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/work.png'),width: 220),
            Text('Phone Verification',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.green),),
            const Text('We need to register your phone before getting started !',style: TextStyle(color: Colors.black54),),
            const SizedBox(height: 25,),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey,width: 2),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: TextField(
                      controller: countryCode,
                      decoration: const InputDecoration(
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  const Text('|',style: TextStyle(fontSize: 35),),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value){
                        phone= value;
                        SignInWithPhone.contact=value;
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                        hintText: 'phone',
                      ),
                    ),
                  )
                ],
              ),
            ),

            ElevatedButton(onPressed: ()async {
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: countryCode.text+phone,
                verificationCompleted: (PhoneAuthCredential credential) {},
                verificationFailed: (FirebaseAuthException e) {},
                codeSent: (String verificationId, int? resendToken) {
                  SignInWithPhone.verify = verificationId;
                  Navigator.pushReplacementNamed(context, "otpVerification");
                },
                codeAutoRetrievalTimeout: (String verificationId) {},
              );

            },
              style: ElevatedButton.styleFrom(backgroundColor:Color(0xff7c7c7c),shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              )),
                child: const Text('Send Code'),
            )

          ],
        ),
      ),
    );
  }
}
