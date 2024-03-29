import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/contants.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
  setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cryptogram',
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor, primaryColor: primayColor),
      home: Center(
        child: CircularProgressIndicator(
          color: primayColor,
        ),
      ),
    );
  }
}
