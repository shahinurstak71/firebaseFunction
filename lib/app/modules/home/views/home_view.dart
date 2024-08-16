
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Obx((){
      
      
      
          return Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: controller.users.length,
              itemBuilder: (BuildContext Context, index){
                  
                final infoUser = controller.users[index];


                print(infoUser.name);
                return Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child:Row(
                    children: [
                      Column(
                        children: [
                          Text(infoUser.name),
                          Text(infoUser.email),
                          Text(infoUser.phoneNumber)
                          
                          
                          
                        ],
                      ),

                      /// passing id for update data
                      IconButton(
                        onPressed: (){
                        Get.toNamed(Routes.SIGNUP, arguments: infoUser);
                          
                         
                          
                          
                          
                        }, 
                        icon: Icon(Icons.edit)
                        ),

                           IconButton(
                        onPressed: (){
                        controller.deleteUser(infoUser.id);
                          
                         
                          
                          
                          
                        }, 
                        icon: Icon(Icons.delete)
                        )
                    ],
                  )              
                  );
                  
              }
              
              ),
          );
        }
      
      
      
      
      
      
      ),
    ),

    floatingActionButton: FloatingActionButton(
      onPressed: (){
        Get.toNamed(Routes.SIGNUP);
      },
      child: Text("send"),
      ),
    );
  }
}
