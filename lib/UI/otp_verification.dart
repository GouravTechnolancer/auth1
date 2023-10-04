import 'package:auth/Model/employee.dart';
import 'package:auth/UI/sign_in_with_phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final FirebaseAuth auth =FirebaseAuth.instance;
  Employee employee = Employee(image: null);
  String code="";

  @override
  Widget build(BuildContext context) {
    Map? data = ModalRoute.of(context)!.settings.arguments as Map;
    employee = data["employee"];

    return Scaffold(
      appBar: AppBar(title: const Text('Phone '),),
      body: Container(
        margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Verification',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            const Text('We need to register your phone before getting started !'),
            const SizedBox(height: 25,),
            Pinput(
              onChanged: (value){
                code=value;
              },
              length: 6,
              showCursor: true,
            ),
            const SizedBox(height: 10,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: ()async{

                PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: SignInWithPhone.verify, smsCode: code);
                await auth.signInWithCredential(credential);
                if(mounted) {
                  Navigator.pushNamed(context, "registerUser",arguments: {
                    'employee': employee,
                    'showPasswordField': false,
                });
                }

              },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade600,shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                )),
                child: const Text('Verified Code'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
