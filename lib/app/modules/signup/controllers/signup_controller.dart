import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/usermodel.dart';

class SignupController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final users = <UserModel>[].obs;

  // Add a new user
  Future<void> addUser(UserModel user) async {
    final docRef = _firestore.collection('users').doc();
    user.id = docRef.id; // Assign Firestore-generated ID
    await docRef.set(user.toMap());
    users.add(user); // Optionally, add the user to the local list
  }

    // Update user data
  Future<void> updateUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).update(user.toMap());
    
    // Optionally update the local list of users
    int index = users.indexWhere((element) => element.id == user.id);
    if (index != -1) {
      users[index] = user;
      users.refresh(); // Refresh the list to reflect changes
    }
  }



}