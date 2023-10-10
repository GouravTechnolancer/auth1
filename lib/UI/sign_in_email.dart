// import 'package:auth/variable.dart';
// import 'package:flutter/material.dart';
// import 'package:email_otp/email_otp.dart';
//
// class SignInWithEmail extends StatefulWidget {
//   const SignInWithEmail({super.key});
//
//   @override
//   State<SignInWithEmail> createState() => _SignInWithEmailState();
// }
//
// class _SignInWithEmailState extends State<SignInWithEmail> {
//   String? email;
//   String? otpcode;
//   EmailOTP myauth = EmailOTP();
//   void sendingotp()async{
//     myauth.setConfig(
//       appEmail: 'Technolancer@gmail.com',
//       appName: 'Email Otp',
//       userEmail: email,
//       otpLength: 4,
//       otpType: OTPType.digitsOnly,);
//     if(await myauth.sendOTP()==true){
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('otp sent')));
//     }
//   }
//   void verifingotp()async{
//     if(await myauth.verifyOTP(otp: otpcode)==true){
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(
//           content: Text("OTP is verified")));
//     }else{
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(
//         content: Text("Invalid OTP"),
//       ));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(title: Text('SignInWithEmail'),centerTitle: true,elevation: 0,backgroundColor: appbar,),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image(image: NetworkImage('https://img.freepik.com/free-vector/emails-concept-illustration_114360-1355.'
//                   'jpg?w=826&t=st=1696922989~exp=1696923589~hmac=760392ddc6ac4f3e10cf7c2613b234c1a38ef1eb6f54029ccb1a4681a73dfc7f'),),
//               Container(
//                 height: 60,
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     hintText: 'Enter Email',
//                     label: Text('EMAIL'),
//                     border: OutlineInputBorder(),
//                       suffix: TextButton(
//                         onPressed: (){
//                           sendingotp();
//                         },
//                         child: Text('send otp'),
//                       )
//                   ),
//                   onChanged: (value){
//                     email = value;
//                   },
//                 ),
//               ),SizedBox(height: 10,),
//               Container(
//                 height: 60,
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       hintText: 'Enter Otp',
//                       label: Text('OTP'),
//                       border: OutlineInputBorder(),
//                   ),
//                   onChanged: (value){
//                     otpcode = value;
//                   },
//                 ),
//               ),
//               SizedBox(height: 20,),
//               ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xff7d7676)),onPressed: (){
//                 verifingotp();
//               }, child: Text('verify otp'))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
