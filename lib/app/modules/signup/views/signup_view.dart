import 'dart:io';

import 'package:firetest/app/data/usermodel.dart';
import 'package:firetest/app/modules/signup/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignupView extends GetView<SignupController> {
  // final UserController userController = Get.put(UserController());
  final UserModel? user = Get
      .arguments; // If user is null, it's an add operation; otherwise, it's an update.
  //File? _selectedImage;
  final _selectedImage = Rx<File?>(null);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: user?.name ?? '');
    TextEditingController emailController =
        TextEditingController(text: user?.email ?? '');
    TextEditingController phoneController =
        TextEditingController(text: user?.phoneNumber ?? '');

    return Scaffold(
      appBar: AppBar(title: Text(user == null ? 'Add User' : 'Update User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() {
              return GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    _selectedImage.value = File(pickedFile.path);
                  }
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _selectedImage.value != null
                      ? FileImage(_selectedImage.value!)
                      : (user?.imageUrl != null
                              ? NetworkImage(user!.imageUrl!)
                              : AssetImage('assets/default_avatar.png'))
                          as ImageProvider,
                  child: Icon(Icons.camera_alt),
                ),
              );
            }),
            SizedBox(height: 20),
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name')),
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email')),
            TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (user == null) {
                  // Add a new user
                  UserModel newUser = UserModel(
                    id: user?.id ?? '',
                    name: nameController.text,
                    email: emailController.text,
                    phoneNumber: phoneController.text,
                  );
                  controller.addUser(newUser, _selectedImage.value);
                  Get.back();
                } else {
                  // Update existing user
                  user!.name = nameController.text;
                  user!.email = emailController.text;
                  user!.phoneNumber = phoneController.text;

                  controller.updateUser(user!, _selectedImage.value);
                  Get.back();
                }
              },
              child: Text(user == null ? 'Add User' : 'Update User'),
            ),
          ],
        ),
      ),
    );
  }
}
