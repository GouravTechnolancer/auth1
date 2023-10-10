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
  late UserProfile employee;
  late StreamSubscription employeeListener;
  bool loading = true;
  void selectImageCamera()async{
    Uint8List img = await pickImageFrom(ImageSource.camera);
    setState(() {
    });
  }
  void selectImageGallery()async{
    Uint8List img = await pickImageFrom(ImageSource.gallery);
    setState(() {
    });
  }

  void getData(){
    String uid = FirebaseAuth.instance.currentUser!.uid;
    print('hello' + '${uid}');
    DocumentReference reference = FirebaseFirestore.instance.collection("user").doc(uid);
    employeeListener = reference.snapshots().listen((DocumentSnapshot snapshot) {
      if(snapshot.exists){
        employee = UserProfile.fromMap(snapshot.id, snapshot.data() as Map<String, dynamic>);
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
    User? user =FirebaseAuth.instance.currentUser;
    print(user!.emailVerified);
    return SafeArea(child:
    Scaffold(
      appBar: AppBar(title: const Text('Profile'),elevation: 0,backgroundColor: appbar,
        automaticallyImplyLeading: false,
      // actions: [
      //   user.emailVerified ? const Text(''):IconButton(onPressed: (){
      //     Navigator.pushNamed(context, 'verifyEmail');
      //   }, icon: const Icon(Icons.email_rounded),),
      // ],
      ),
        body: SingleChildScrollView(
          child: loading ? const Center(child: CircularProgressIndicator(),) :
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    employee.image != null ? CircleAvatar(
                      radius: 70,
                      // backgroundImage: MemoryImage(_image!),
                      backgroundImage: NetworkImage(employee.image!)
                    ):
                    const CircleAvatar(
                        radius: 70,
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
                    ElevatedButton(onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff7d7676)),
                      child: const Text('Edit Profile'),),
                    const SizedBox(width: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        user.emailVerified == false ? ElevatedButton(onPressed: () {
                            Navigator.pushNamed(context, 'verifyEmail');
                        },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0x0000000a)),
                          child: user!.emailVerified ? Row(
                            children: [
                              Icon(Icons.mail),
                              SizedBox(width: 3,),
                              Text('Verified',style: TextStyle(color: Colors.greenAccent))
                            ],
                          ): Row(children: [
                            Icon(Icons.cancel,color: Colors.red,),
                            SizedBox(width: 3,),
                            Text('Not Verified',style: TextStyle(color: Colors.red))
                          ],)
                        ):ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor: Color(0xff7d7676)),onPressed: (){}, child:  Row(
                          children: [
                            Icon(Icons.mail),
                            SizedBox(width: 3,),
                            Text('Verified',style: TextStyle(color: Colors.greenAccent))
                          ],
                        )),

                        const SizedBox(height: 15,),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: SizedBox(
                          height: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Row(
                              children: [
                                Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                                Icon(Icons.person, color: Colors.white),
                                SizedBox(width: 20,),
                                Text('Name', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      flex: 4,
                      child: SizedBox(
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
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
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
                                Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                                Icon(Icons.cake, color: Colors.white,),
                                SizedBox(width: 20,),
                                Text('Age', style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      flex: 4,
                      child: SizedBox(
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
                          )),
                    )
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
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
                                Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
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
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      flex: 4,
                      child: SizedBox(
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
                      ),
                    )

                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
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
                                Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
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
                    ),
                    const SizedBox(width: 10,),
                    user.emailVerified == false ?
                    Expanded(
                      flex:4,
                      child: SizedBox(
                        width: 180,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.redAccent,
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
                      ),
                    )
                        :
                    Expanded

                      (
                      flex:4,
                      child: SizedBox(
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
                                  hintText: employee.email,
                              ),
                            ),
                          ),),
                        ),
                      ),
                    )

                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
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
                                Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
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
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      flex: 4,
                      child: SizedBox(
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
                      ),
                    )

                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
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
                                Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
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
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      flex: 4,
                      child: SizedBox(
                        width: 180,
                        height: 40,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                      backgroundColor: const Color(0xff7d7676)),
                  child: const Text('Logout'),),
                Container(
                    width: double.infinity,
                    height: 15,
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle
                    ),
                    child: GestureDetector(
                      onTap: (){
                      },
                      child: const Center(child: Text('Term & Conditions',
                        style: TextStyle(color: Colors.blue),),),
                    )
                ),
              ],
            ),
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