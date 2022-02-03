import 'package:flutter/material.dart';
import 'package:tiktok_clone/contants.dart';
import 'package:tiktok_clone/views/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTok Clone',
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor, primaryColor: primayColor),
      home: const RegisterScreen(),
    );
  }
}
