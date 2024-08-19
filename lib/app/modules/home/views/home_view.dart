import 'package:firetest/app/data/usermodel.dart';
import 'package:firetest/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: Obx(() {
        if (controller.users.isEmpty) {
          return Center(child: Text('No users found.'));
        }
        return ListView.builder(
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            UserModel user = controller.users[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: user.imageUrl !=null
                    ? NetworkImage(user.imageUrl!)
                    : AssetImage('assets/default_avatar.png') as ImageProvider,
              ),
              title: Text(user.name),
              subtitle: Text(user.email),
              trailing: IconButton(
                onPressed: (){
                  controller.deleteUser(user.id);
                },
                 icon: Icon(Icons.delete)
                 ),
              onTap: () {
              Get.toNamed(Routes.SIGNUP, arguments: user);
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/signup');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
