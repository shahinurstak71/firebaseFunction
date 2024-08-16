

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/usermodel.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 final users =<UserModel>[].obs;
  var isLoading = false.obs;

  @override
 void onInit(){
  super.onInit();
  fetchUsers();
 }

  /// Fatch users data by user doc id
  Future<void> fetchUsers ()async{
    isLoading(false);
    final snapshot = await _firestore.collection('users').get();
    final data = snapshot.docs.map((doc)=> UserModel.fromMap(doc.data(), doc.id)).toList();
    users.assignAll(data);
  }

    // Delete a user
  Future<void> deleteUser(String id) async {
    await _firestore.collection('users').doc(id).delete();
    
    // Optionally remove the user from the local list
    //users.removeWhere((user) => user.id == id);
  }
  // var userList = <User>[].obs;
  // var isLoading = false.obs;
  // @override
  // void onInit() {
  //   super.onInit();
  //   // fetchUserData();
  // }

// firebase user data fatch this function 

  // void fetchUserData() async {
  //   try {
  //     isLoading(false);
  //     QuerySnapshot snapshot =
  //         await FirebaseFirestore.instance.collection('user').get();

  //     var userdata =
  //         snapshot.docs.map((doc) => User.fromFirestore(doc)).toList();

  //     userList.value = userdata;
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString());
  //   }
  // }
}
