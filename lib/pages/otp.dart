import 'package:auth/pages/phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final FirebaseAuth auth =FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code="";
    return Scaffold(
      appBar: AppBar(title: Text('Phone '),),
      body: Container(
        margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Verification',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            Text('We need to register your phone before getting started !'),
            SizedBox(height: 25,),
            Pinput(
              onChanged: (value){
                code=value;
              },
              length: 6,
              showCursor: true,
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: ()async{
                PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: Phone.verify, smsCode: code);
                await auth.signInWithCredential(credential);
                Navigator.pushNamed(context, "listofauth");

              },
                child: Text('Verified Code'),
                style: ElevatedButton.styleFrom(primary: Colors.green.shade600,shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                )),
              ),
            )


          ],
        ),
      ),
    );
  }
}
