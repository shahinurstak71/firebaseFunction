import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'IzaSyCdECWa2gNPFjvFvxRsgmurPPv9i1hFWdw', 
      appId: '1:198583559989:android:40400f5367879210d48e7c', 
      messagingSenderId: '198583559989',
       projectId: 'firetest-3c477'
       )
  );
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
