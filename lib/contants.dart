import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/views/screens/feed_screen.dart';
import 'package:tiktok_clone/views/screens/message_screen.dart';
import 'package:tiktok_clone/views/screens/post_screen.dart';
import 'package:tiktok_clone/views/screens/profile_screen.dart';
import 'package:tiktok_clone/views/screens/search_screen.dart';

//
const pages = [
  FeedScreen(),
  SearchScreen(),
  PostScreen(),
  MessageScreen(),
  ProfileScreen(),
];

// *Colors
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;
var primayColor = Colors.red[400];

// *Firebase Instance
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var cloudFirestore = FirebaseFirestore.instance;

//* AuthController Instance
var authController = AuthController.instance;
