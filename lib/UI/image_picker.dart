import 'dart:io';
import 'package:auth/Model/employee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
pickImageFrom(ImageSource source)async{
  Employee employee = Employee(image: null);
  final ImagePicker _imagePicker =ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  print('${_file?.path}');
  if(_file != null){
    String imageUrl ='';
    String uniqueFileName = DateTime.now().millisecond. toString();
    Reference referenceRoot =FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('images');
    Reference referenceImageToUpload =referenceDirImage.child(uniqueFileName);
    print(uniqueFileName);
    try{
      await referenceImageToUpload.putFile(File(_file!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      User? user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection("user").doc(user!.uid).update({'image': imageUrl});
      employee.image = imageUrl;
    }catch(e){
      print('error not found ');
    }
    // return await _file.readAsBytes();
    return await _file.readAsBytes();
  }else{
    print('no image select');
  }
}