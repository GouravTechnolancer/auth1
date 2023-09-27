import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  Map data = {};

  // File ? _selectedImage;
  File? pickedFile;
  ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    data = ModalRoute
        .of(context)
        ?.settings
        .arguments as Map;
    return SafeArea(child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile',
            style: TextStyle(color: Colors.black),),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black,),
            onPressed: () {
              Navigator.pop(context);
            },),
          actions: const [
            Icon(Icons.notifications, color: Colors.black)
          ],
        ),

        body: ListView(
          children: [
            Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(width: 4, color: Colors.white),
                          // image: DecorationImage(
                          //   // image: _selectedImage! == null ?AssetImage('assets/register.png'): AssetImage(FileImage(_selectedImage?.path as File) as String),
                          //   // fit: BoxFit.cover
                          // )
                        ),
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
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(onPressed: () {

                },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x0000000a)),
                  child: const Text('Edit Profile'),),
                const SizedBox(height: 25,),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: SizedBox(
                        width: 150,
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
                                hintText: '${data['name']}'
                            ),
                          ),
                        )),
                      ),
                    )

                  ],
                ),
                const SizedBox(height: 25,),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: SizedBox(
                        width: 150,
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
                                  hintText: '${data['age']}'
                              ),
                            ),
                          )),
                          ),
                        ))
                  ],
                ),
                const SizedBox(height: 25,),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: SizedBox(
                        width: 150,
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
                                hintText: '${data['gender']}'
                            ),
                          ),
                        ),),
                      ),
                    )

                  ],
                ),
                const SizedBox(height: 25,),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: SizedBox(
                        width: 150,
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
                                hintText: '${data['email']}'
                            ),
                          ),
                        ),),
                      ),
                    )

                  ],
                ),
                const SizedBox(height: 25,),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: SizedBox(
                        width: 150,
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
                                hintText: '${data['phone']}'
                            ),
                          ),
                        ),),
                      ),
                    )

                  ],
                ),
                const SizedBox(height: 25,),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: SizedBox(
                        width: 150,
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey,
                        ),
                        child: Center(child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                                hintText: '${data['dob']}'
                            ),
                          ),
                        ),),
                      ),
                    )

                  ],
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Column(
                children: [
                  ElevatedButton(onPressed: () {},
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
                ]),

          ],
        ),
        bottomNavigationBar: Row(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(40, 0, 0, 0),
              width: 50,
              height: 50,
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/messenger.png'),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(40, 0, 0, 0),
              width: 50,
              height: 50,
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/linkedin.png'),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(40, 0, 0, 0),
              width: 50,
              height: 50,
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/instagram.png'),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/facebook.png'),
              ),
            ),


          ],
        )
    )
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 100,
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text('Choose profile photo', style: TextStyle(fontSize: 20.0),)
          , SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(onPressed: () {
                _pickImageFrom(ImageSource.gallery);
              }, icon: Icon(Icons.image), label: Text('gallery')),
              SizedBox(width: 50,),
              ElevatedButton.icon(onPressed: () {
                _pickImageFrom(ImageSource.camera);
              }, icon: Icon(Icons.camera), label: Text('camera'))
            ],
          )
        ],
      ),
    );
  }

  //Images picker from Gallery
  Future<void> _pickImageFrom(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    // final returnedCamera = await ImagePicker().pickImage(source: ImageSource.camera);
    pickedFile = File(pickedImage!.path);
    print(pickedFile);
    //   setState(() {
    //     _selectedImage = File(returnedImage!.path);
    //     // _selectedImage = File(returnedCamera!.path);
    //   });
  }

  // Images picker from camera
  // Future _pickImageFromGallery(ImageSource source) async {
  //   final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   pickedFile = File(pickedImage!.path);
  //   print(pickedFile);
  //   // setState(() {
  //   //   _selectedImage = File(returnedCamera!.path);
  //   // });

  }
}