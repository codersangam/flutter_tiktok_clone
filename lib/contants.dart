import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/views/screens/feed_screen.dart';
import 'package:tiktok_clone/views/screens/post_screen.dart';
import 'package:tiktok_clone/views/screens/profile_screen.dart';
import 'package:tiktok_clone/views/screens/search_screen.dart';
import 'views/screens/messages/message_home_screen.dart';

//
List pages = [
  const FeedScreen(),
  const SearchScreen(),
  const PostScreen(),
  const MessageHomeScreen(),
  ProfileScreen(
    uId: authController.user!.uid,
  ),
];

// *Colors
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;
var primayColor = Colors.red[400];
var secondaryColor = const Color.fromRGBO(38, 38, 38, 1);

// *Firebase Instance
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
FirebaseFirestore cloudFirestore = FirebaseFirestore.instance;

//* AuthController Instance
var authController = AuthController.instance;
