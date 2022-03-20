import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/contants.dart';
import 'package:tiktok_clone/models/user_model.dart';

class ChatRoomScreen extends StatelessWidget {
  ChatRoomScreen(
      {Key? key,
      required this.userMap,
      required this.chatRoomId,
      required this.userModel})
      : super(key: key);

  final Map<String, dynamic> userMap;
  final String chatRoomId;
  final UserModel userModel;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _messageController = TextEditingController();
  void onSendMessage() async {
    if (_messageController.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendBy": _auth.currentUser?.displayName,
        "message": _messageController.text,
        "time": FieldValue.serverTimestamp(),
      };
      _messageController.clear();
      await cloudFirestore
          .collection('ChatRoom')
          .doc(chatRoomId)
          .collection('Chats')
          .add(messages);
    } else {
      // ignore: avoid_print
      print('Enter some text');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(userMap['userName']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 1.25,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                  stream: cloudFirestore
                      .collection('ChatRoom')
                      .doc(chatRoomId)
                      .collection('Chats')
                      .orderBy('time', descending: false)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> map =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            return messages(size, map);
                          });
                    } else {
                      return Container();
                    }
                  }),
            ),
            Container(
              height: size.height / 10,
              width: size.width,
              alignment: Alignment.center,
              child: SizedBox(
                height: size.height / 12,
                width: size.width / 1.1,
                child: Row(
                  children: [
                    SizedBox(
                      height: size.height / 17,
                      width: size.width / 1.3,
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                            hintText: "Send Message",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      ),
                    ),
                    IconButton(
                        icon: const Icon(Icons.send), onPressed: onSendMessage),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map) {
    return Container(
      width: size.width,
      alignment: map['sendBy'] == _auth.currentUser!.displayName
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.red,
        ),
        child: Text(
          map['message'],
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
