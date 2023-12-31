import 'package:auth/variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Model/employee.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {

  final TextEditingController _dateController = TextEditingController();
  final _formKey =GlobalKey<FormState>();
  UserProfile employee = UserProfile(image: null);
  Map? data;
  String? numbers;
  String? chooseValue;
  List<String> listItem=[
    'Male',
    'Female'
  ];
  String? name;
  String? email;
  String? password;
  //bool showPasswordField = true;
  @override
  Widget build(context) {
    data = ModalRoute.of(context)!.settings.arguments as Map?;
    employee = data?["employee"] ?? UserProfile(image: null);
    print(employee);
    print(data!['users']);
    name = data!["name"];
    email =data!["email"];
    bool showPasswordField = data!["showPasswordField"];
    if(data!['name']!=null) {
      employee.name ='${data!['name']}' ;
    }
    if(data!['email']!=null) {
      employee.email ='${data!['email']}' ;
    }
    if(data!['phone']!=null){employee.phoneNumber='${data!['email']}';}
    if(showPasswordField == false){
      employee.password = 'Gou@4545454545@';
    }

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
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 40),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10,),
              const Image(image:AssetImage('assets/work.png'),width: 220),
              const SizedBox(height: 20,),
              const Text('Register yourself',style: TextStyle(fontWeight: FontWeight.bold),),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: name,
                        decoration: const InputDecoration(
                          hintText: 'Enter Name',
                          border: OutlineInputBorder(),
                          label: Text('Name'),
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
                        initialValue: email,
                        decoration: const InputDecoration(
                            hintText: 'Enter Email',
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
                      Visibility(
                        visible: showPasswordField,
                        child: TextFormField(
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
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter Password',
                          label: Text('Age'),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value){
                          employee.age=value;
                        },),
                      const SizedBox(height: 10,),
                      //Gender
                      SizedBox(
                        height:60,
                        child: DropdownButtonFormField(
                          hint: const Text('Gender'),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder()
                          ),
                          isExpanded: true,
                          value: chooseValue,
                          onChanged: (value){
                            employee.gender=value;
                          },
                          items: listItem.map((valueItem) {
                            return DropdownMenuItem(
                                value:valueItem,
                                child: Text(valueItem,style: TextStyle(color: Colors.grey.shade600),)
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      //Date-Of-Birth
                      TextFormField(
                        controller: _dateController,
                        decoration: const InputDecoration(
                          hintText: 'Select a date',
                          label: Text('DateOfBirth'),
                          border: OutlineInputBorder(),
                        ),
                        // onTap: _selectDate,
                        onChanged: (value){
                          employee.dob=value;
                        },
                      ),
                      const SizedBox(height: 20,),
                      SizedBox(
                        width:220,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff7c7c7c)),
                            onPressed: ()async{
                              if(_formKey.currentState!.validate())
                                {
                                  User? user;
                                  employee.isVerified =false;
                                  if(showPasswordField == true) {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                        email: employee.email!,
                                        password: employee.password!);
                                    await FirebaseAuth.instance.signInWithEmailAndPassword(email: employee.email!, password: employee.password!);
                                  }
                                  user = FirebaseAuth.instance.currentUser;
                                  print(user);
                                    await FirebaseFirestore.instance.collection(
                                        'user').doc(user!.uid).set(
                                        employee.toJson());
                                    if (mounted) {
                                      Navigator.pushNamed(context, 'home');
                                    }

                                }
                                // {
                                //   User? user = FirebaseAuth.instance.currentUser;
                                //   // pd.show(msg: "please wait ",backgroundColor: Colors.grey, );
                                //   if(employee.phoneNumber == null){
                                //     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: employee.email!, password: employee.password!).then((value)async {
                                //       await FirebaseFirestore.instance.collection("user").doc(user!.uid).set(employee.toJson());
                                //       // pd.close();
                                //     });
                                //   }else if(employee.email !=null){
                                //     FirebaseFirestore.instance.collection('user').doc(user!.uid).set(employee.toJson());
                                //   }else if(employee.phoneNumber!=null){
                                //     FirebaseFirestore.instance.collection('user').doc(user!.uid).set(employee.toJson());
                                //   }
                                //   if(mounted) {
                                //     Navigator.pushNamed(context, "home");
                                //   }
                                // }
                            },
                            child: const Text('SignUp')
                        ),
                      )
                    ],
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
