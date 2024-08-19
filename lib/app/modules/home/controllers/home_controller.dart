import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firetest/app/data/usermodel.dart';
import 'package:get/get.dart';



class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var users = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').get();
      users.value = snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Delete a user data by cath id
  Future<void> deleteUser(String id) async{
    await _firestore.collection("users").doc(id).delete();
  }
}
