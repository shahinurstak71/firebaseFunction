import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firetest/app/data/usermodel.dart';
import 'package:get/get.dart';
import 'dart:io';




class SignupController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;


  var name = ''.obs;
  var email = ''.obs;
  var phoneNumber = ''.obs;
  // var imageFile = Rx<File?>(null);

 // Pick image from gallery metthod
  // void pickImage() async {
  //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
      
  //     imageFile.value = File(pickedFile.path) ;
  //   }
  // }

  // Add user data in firebase firestore and storage testing 

    Future<void> addUser(UserModel user, File? image) async {
    try {
      if (image != null) {
        String fileName = 'users/${user.id}.jpg';
        TaskSnapshot snapshot = await _storage.ref(fileName).putFile(image);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        user.imageUrl = downloadUrl;
      }

      DocumentReference docRef = await _firestore.collection('users').add(user.toMap());
      user.id = docRef.id;
      await _firestore.collection('users').doc(docRef.id).update({'id': docRef.id});
      Get.snackbar("Success", "User added successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to add user: $e");
    }
  }

 // Add user data in firebase firestore and storage running
  // Future<void> createUser(UserModel user, File?image) async {
  //   try {
  //     String id = DateTime.now().millisecondsSinceEpoch.toString();
  //     String imageUrl = '';

  //     if (imageFile.value != null) {
  //       imageUrl = await uploadImage(id, imageFile.value!);
  //     }

  //     UserModel user = UserModel(
  //       id: id,
  //       name: name.value,
  //       email: email.value,
  //       phoneNumber: phoneNumber.value,
  //       imageUrl: imageUrl,
  //     );

  //     await _firestore.collection('users').doc(id).set(user.toMap());
  //     Get.snackbar("success", "upload done");
  //     Get.back();
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString());
  //   }
  // }


 //Upload image in storage using this method
  Future<String> uploadImage(String userId, File imageFile) async {
    try {
      final ref = _storage.ref().child('users/$userId/avatar.jpg');
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return '';
    }
  }
// Update user all information

 // Update existing user data
  Future<void> updateUser(UserModel user, File? newImage) async {
    try {
      if (newImage != null) {
        String fileName = 'users/${user.id}.jpg';
        TaskSnapshot snapshot = await _storage.ref(fileName).putFile(newImage);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        user.imageUrl = downloadUrl;
      }

      await _firestore.collection('users').doc(user.id).update(user.toMap());
      Get.snackbar("Success", "User updated successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to update user: $e");
    }
  }



  
}
