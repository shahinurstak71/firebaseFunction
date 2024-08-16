
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../data/usermodel.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  //final UserController userController = Get.put(UserController());
  final UserModel? user =Get.arguments;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {


  /// pre-fill the form fields with the current user data
  if(user != null){
    nameController.text = user!.name;
    emailController.text = user!.email;
    phoneController.text = user!.phoneNumber;
  }


    return Scaffold(
      appBar: AppBar(title: Text('Add User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text(user == null? 'Add User' : 'Update User'),
              onPressed: () async {
                //final docRef = FirebaseFirestore.instance.collection('users').doc();
                final newUser = UserModel(
                  id: user?.id ?? '', // ID will be set by Firestore
                  name: nameController.text,
                  email: emailController.text,
                  phoneNumber: phoneController.text,
                );


               if(user == null){
                 await controller.addUser(newUser);
               }else{
                await controller.updateUser(newUser);

               }


                Get.back(); // Go back after adding the user
              },
            ),
          ],
        ),
      ),
    );
  }
}
