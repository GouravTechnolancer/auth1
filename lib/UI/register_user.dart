import 'package:auth/UI/sign_in_with_phone.dart';
import 'package:auth/variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import '../Model/employee.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {

  final _formKey =GlobalKey<FormState>();
  Employee employee = Employee();
  Map? data;
  String? numbers;

  String? chooseValue;
  List<String> listItem=[
    'Male',
    'Female'
  ];

  @override
  Widget build(context) {
    data = ModalRoute.of(context)!.settings.arguments as Map?;
    employee = data?["employee"] ?? Employee();
    print('${employee.phoneNumber}');
    ProgressDialog pd = ProgressDialog(context: context);
    print(employee);
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: appbar,
        title: const Text('Register User'),
      ),
      body: SingleChildScrollView(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 10,
          margin: EdgeInsets.fromLTRB(20, 10, 20, 40),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Image(image:AssetImage('assets/work.png'),width: 220),
              SizedBox(height: 20,),
              Text('Register yourself',style: TextStyle(fontWeight: FontWeight.bold),),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: employee.name,
                          decoration: const InputDecoration(
                            hintText: 'Enter Full Name',
                            border: OutlineInputBorder(),
                            label: Text('Name')
                          ),
                          onChanged: ((val) => employee.name = val),
                          validator: ((val) => val!.isEmpty ? "Enter Valid Name" : null),
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          initialValue: employee.phoneNumber,
                          decoration: const InputDecoration(
                              hintText: 'Enter your contact',
                              border: OutlineInputBorder(),
                              label: Text('Phone')
                          ),
                          onChanged: ((val) => employee.phoneNumber = val),
                          validator: ((val) => val!.isEmpty ? "Enter contact number" : null),
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Enter your Email',
                              label: Text('Email'),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value){
                              employee.email=value;
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "Enter your email correct";
                            }else{
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: 'Enter Password',
                              label: Text('Password'),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value){
                              employee.password=value;
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "Password cannot be empty";
                            }if (!value.contains(RegExp(r'[A-Z]'))) {
                              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('The password must contain at least one uppercase letter')));
                              return 'The password must contain at least one uppercase letter.';
                            }
                            if (!value.contains(RegExp(r'[a-z]'))) {
                              return 'The password must contain at least one lowercase letter.';
                            }
                            if (!value.contains(RegExp(r'[0-9]'))) {
                              return 'The password must contain at least one number.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Enter Password',
                            label: Text('Age'),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value){
                            employee.age=value;
                          },),
                        const SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width:1,color: Colors.grey)
                          ),
                          child: DropdownButton(
                            icon: Icon(Icons.arrow_drop_down),
                            isExpanded: true,
                            underline: SizedBox(),
                            value: chooseValue,
                            onChanged: (value){
                              setState(() {
                                chooseValue=value;
                                employee.gender=value;
                                print('${employee.age}'+'${employee.dob}'+'${employee.gender}'+'${employee.email}'+'${employee.phoneNumber}'+'${employee.name}');
                              });
                            },
                            items: listItem.map((valueItem) {
                              return DropdownMenuItem(
                                  value:valueItem,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(valueItem,style: TextStyle(color: Colors.grey.shade600),),
                                  )
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          initialValue: employee.dob,
                          decoration: const InputDecoration(
                            hintText: 'dd-mm-yyyy',
                            label: Text('DateOfBirth'),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value){
                            employee.dob=value;
                          },),
                        const SizedBox(height: 20,),
                        Container(
                          width:220,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Color(0xff7c7c7c)),
                              onPressed: ()async{
                                if(_formKey.currentState!.validate())
                                  {
                                    pd.show(msg: "please wait ",backgroundColor: Colors.green.shade600, );
                                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                          email: employee.email!,
                                          password: employee.password!).then((value)async {
                                            User? user = FirebaseAuth.instance.currentUser;
                                             await FirebaseFirestore.instance.collection("user").doc(user!.uid).set(employee.toJson());
                                             pd.close();
                                             if(mounted)Navigator.pushNamed(context, "profile",arguments: {
                                               'name': employee.name,
                                               'phone':employee.phoneNumber,
                                               'email':employee.email,
                                               'age':employee.age,
                                               'dob':employee.dob,
                                               'gender':employee.gender
                                             });

                                      });
                                  }
                              },
                              child: const Text('SignUp')
                          ),
                        )


                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
