import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/contants.dart';
import 'package:tiktok_clone/models/chat_room_model.dart';
import 'package:tiktok_clone/models/message_model.dart';
import 'package:tiktok_clone/models/user_model.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen(
      {Key? key,
      required this.userModel,
      required this.targetUser,
      required this.chatRoomModel,
      required this.firebaseUser})
      : super(key: key);

  final UserModel userModel;
  final UserModel targetUser;
  final ChatRoomModel chatRoomModel;
  final User firebaseUser;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _chatController = TextEditingController();

  void sendMessage() {
    var uuid = const Uuid();
    String chat = _chatController.text;
    _chatController.clear();
    MessageModel newMessage = MessageModel(
      messageId: uuid.v1(),
      message: chat,
      sender: widget.userModel.uId,
      seen: false,
      time: DateTime.now(),
    );
    cloudFirestore
        .collection('ChatRooms')
        .doc(widget.chatRoomModel.chatRoomId)
        .collection('Messages')
        .doc(newMessage.messageId)
        .set(
          newMessage.toMap(),
        );

    widget.chatRoomModel.lastMessage = chat;
    cloudFirestore
        .collection("ChatRooms")
        .doc(widget.chatRoomModel.chatRoomId)
        .set(widget.chatRoomModel.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              backgroundImage: NetworkImage(
                widget.targetUser.profileImage.toString(),
              ),
            ),
            10.widthBox,
            Text(
              widget.targetUser.userName.toString(),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: cloudFirestore
                      .collection('ChatRooms')
                      .doc(widget.chatRoomModel.chatRoomId)
                      .collection('Messages')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        QuerySnapshot querySnapshot =
                            snapshot.data as QuerySnapshot;
                        return ListView.builder(
                            reverse: true,
                            itemCount: querySnapshot.docs.length,
                            itemBuilder: (context, index) {
                              MessageModel currentMessage =
                                  MessageModel.fromMap(querySnapshot.docs[index]
                                      .data() as Map<String, dynamic>);
                              return Row(
                                mainAxisAlignment: (currentMessage.sender ==
                                        widget.userModel.uId)
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: (currentMessage.sender ==
                                                widget.userModel.uId)
                                            ? Colors.grey
                                            : Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        currentMessage.message.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                              );
                            });
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                              "An error occured! Please check your internet connection."),
                        );
                      } else {
                        return const Center(
                          child: Text("Say hi to your new friend"),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            Container(
              color: Colors.grey[500],
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _chatController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Enter Message',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      sendMessage();
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
