import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Phone extends StatefulWidget {
  static String verify="";

  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
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
      appBar: AppBar(title: Text('Phone '),),
      body: Container(
        margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Phone Verification',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            Text('We need to register your phone before getting started !'),
            SizedBox(height: 25,),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                      decoration: InputDecoration(
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  Text('|',style: TextStyle(fontSize: 35),),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value){
                        phone= value;
                      },
                      decoration: InputDecoration(
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
                phoneNumber: '${countryCode.text+phone}',
                verificationCompleted: (PhoneAuthCredential credential) {},
                verificationFailed: (FirebaseAuthException e) {},
                codeSent: (String verificationId, int? resendToken) {
                  Phone.verify = verificationId;
                  Navigator.pushNamed(context, "otp");
                },
                codeAutoRetrievalTimeout: (String verificationId) {},
              );

            },
                child: Text('Send Code'),
              style: ElevatedButton.styleFrom(primary: Colors.green.shade600,shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              )),
            )

          ],
        ),
      ),
    );
  }
}
