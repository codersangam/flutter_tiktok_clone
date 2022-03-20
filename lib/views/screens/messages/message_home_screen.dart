import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/contants.dart';
import 'package:tiktok_clone/helper/firebase_helper.dart';
import 'package:tiktok_clone/views/screens/messages/message_search_screen.dart';

import '../../../models/user_model.dart';

class MessageHomeScreen extends StatelessWidget {
  const MessageHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currentUser = firebaseAuth.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          UserModel? thisUserModel =
              await FirebaseHelper.getUserModelById(currentUser!.uid);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MessageSearchScreen(
                userModel: thisUserModel!,
              ),
            ),
          );
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
