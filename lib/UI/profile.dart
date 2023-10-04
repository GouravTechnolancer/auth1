import 'dart:async';
import 'package:auth/Model/employee.dart';
import 'package:auth/UI/image_picker.dart';
import 'package:auth/variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  late Employee employee;
  late StreamSubscription employeeListener;
  bool loading = true;
  Uint8List? _image;
  void selectImageCamera()async{
    Uint8List img = await pickImageFrom(ImageSource.camera);
    setState(() {
      _image = img;
    });
  }
  void selectImageGallery()async{
    Uint8List img = await pickImageFrom(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void getData(){
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference reference = FirebaseFirestore.instance.collection("user").doc(uid);
    employeeListener = reference.snapshots().listen((DocumentSnapshot snapshot) {
      if(snapshot.exists){
        employee = Employee.fromMap(snapshot.id, snapshot.data() as Map<String, dynamic>);
        print(employee.image);
      }
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(

        appBar: AppBar(title: const Text('Profile', style: TextStyle(color: Colors.black),),
          centerTitle: true,
          elevation: 0,
          backgroundColor: appbar,
          leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black,),
            onPressed: () {
              Navigator.pop(context);
            },),
          actions: const [
            Icon(Icons.notifications, color: Colors.black)
          ],
        ),
        body: loading ? const Center(child: CircularProgressIndicator(
        ),) : Container(
          color: Colors.white,
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(height: 10,),
                  Stack(
                    children: [
                      employee.image != null ? CircleAvatar(
                        radius: 70,
                        // backgroundImage: MemoryImage(_image!),
                        backgroundImage: NetworkImage(employee.image!)
                      ):
                      const CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('assets/user.png'),
                        backgroundColor: Colors.transparent,
                      ),
                      Positioned(
                          bottom: 0,
                          right: 5,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade400,
                                border: Border.all(
                                    width: 2, color: Colors.white)
                            ),
                            child: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  showModalBottomSheet(context: context,
                                      builder: (builder) => bottomsheet());
                                }

                            ),
                          )
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: () {

                       },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0x0000000a)),
                        child: const Text('Edit Profile'),),
                      const SizedBox(height: 25,),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: SizedBox(
                          width: 175,
                          height: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Row(
                              children: [
                                SizedBox(width: 20,),
                                Icon(Icons.person, color: Colors.white),
                                SizedBox(width: 20,),
                                Text('Name', style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      SizedBox(
                        width: 180,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey,
                          ),
                          child: Center(child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                  hintText: employee.name
                              ),
                            ),
                          )),
                        ),
                      )

                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: SizedBox(
                          width: 175,
                          height: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Row(
                              children: [
                                SizedBox(width: 20,),
                                Icon(Icons.edit, color: Colors.white,),
                                SizedBox(width: 20,),
                                Text('Age', style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      SizedBox(
                          width: 180,
                          height: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey,
                            ),
                            child: Center(child:
                            Center(child: Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                    hintText: employee.age
                                ),
                              ),
                            )),
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: SizedBox(
                          width: 175,
                          height: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Row(
                              children: [
                                SizedBox(width: 20,),
                                Icon(Icons.person, color: Colors.white,),
                                SizedBox(width: 20,),
                                Text('Gender', style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      SizedBox(
                        width: 180,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey,
                          ),
                          child: Center(child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                  hintText: employee.gender
                              ),
                            ),
                          ),),
                        ),
                      )

                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: SizedBox(
                          width: 175,
                          height: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Row(
                              children: [
                                SizedBox(width: 20,),
                                Icon(Icons.mail, color: Colors.white,),
                                SizedBox(width: 20,),
                                Text('Email', style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      SizedBox(
                        width: 180,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey,
                          ),
                          child: Center(child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                  hintText: employee.email
                              ),
                            ),
                          ),),
                        ),
                      )

                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: SizedBox(
                          width: 175,
                          height: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Row(
                              children: [
                                SizedBox(width: 20,),
                                Icon(Icons.phone, color: Colors.white,),
                                SizedBox(width: 20,),
                                Text('Phone', style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      SizedBox(
                        width: 180,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey,
                          ),
                          child: Center(child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                  hintText: employee.phoneNumber
                              ),
                            ),
                          ),),
                        ),
                      )

                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: SizedBox(
                          width: 175,
                          height: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Row(
                              children: [
                                SizedBox(width: 20,),
                                Icon(Icons.calendar_month, color: Colors.white,),
                                SizedBox(width: 20,),
                                Text('D-O-B', style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      SizedBox(
                        width: 180,
                        height: 40,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey,
                          ),
                          child: Center(child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                  hintText: employee.dob
                              ),
                            ),
                          ),),
                        ),
                      )

                    ],
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(onPressed: () async{
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(context, 'chooseAuthMethod');
                  },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0x0000000a)),
                    child: const Text('Logout'),),
                  Container(
                      width: double.infinity,
                      height: 15,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle
                      ),
                      child: const Center(child: Text('Term & Conditions',
                        style: TextStyle(color: Colors.blue),),)
                  ),
                  const Divider(thickness: 3,)
                ],
              ),
            ],
          ),
        ),
        // bottomNavigationBar: Row(
        //   children: [
        //     Container(
        //       margin: const EdgeInsets.fromLTRB(40, 0, 0, 0),
        //       width: 50,
        //       height: 50,
        //       child: const CircleAvatar(
        //         backgroundImage: AssetImage('assets/messenger.png'),
        //       ),
        //     ),
        //     Container(
        //       margin: const EdgeInsets.fromLTRB(40, 0, 0, 0),
        //       width: 50,
        //       height: 50,
        //       child: const CircleAvatar(
        //         backgroundImage: AssetImage('assets/linkedin.png'),
        //       ),
        //     ),
        //     Container(
        //       margin: const EdgeInsets.fromLTRB(40, 0, 0, 0),
        //       width: 50,
        //       height: 50,
        //       child: const CircleAvatar(
        //         backgroundImage: AssetImage('assets/instagram.png'),
        //       ),
        //     ),
        //     Container(
        //       width: 50,
        //       height: 50,
        //       margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
        //       child: const CircleAvatar(
        //         backgroundImage: AssetImage('assets/facebook.png'),
        //       ),
        //     ),
        //
        //
        //   ],
        // )
    )
    );
  }

  Widget bottomsheet() {
    return Container(
      color:Colors.grey,
      child: Container(
        height: 100,
        width: MediaQuery
            .of(context)
            .size
            .width,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            const Text('Choose Profile Photo', style: TextStyle(fontSize: 20.0),)
            , const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.black),onPressed: () {
                  selectImageGallery();
                }, icon: const Icon(Icons.image,), label: const Text('Gallery')),
                const SizedBox(width: 50,),
                ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.black),onPressed: () {
                  selectImageCamera();
                }, icon: const Icon(Icons.camera), label: const Text('Camera'))
              ],
            )
          ],
        ),
      ),
    );
  }



}