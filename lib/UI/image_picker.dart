import 'dart:io';
import 'package:auth/Model/employee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
pickImageFrom(ImageSource source)async{
  UserProfile employee = UserProfile(image: null);
  final ImagePicker imagePicker =ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if(file != null){
    String imageUrl ='';
    String uniqueFileName = DateTime.now().millisecond. toString();
    Reference referenceRoot =FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('images');
    Reference referenceImageToUpload =referenceDirImage.child(uniqueFileName);
    try{
      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      User? user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection("user").doc(user!.uid).update({'image': imageUrl});
      employee.image = imageUrl;
    }catch(e){
    }
    return await file.readAsBytes();
  }else{
  }
}