import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/contants.dart';
import 'package:tiktok_clone/models/chat_room_model.dart';
import 'package:tiktok_clone/models/user_model.dart';
import 'package:tiktok_clone/views/screens/messages/chat_room_screen.dart';
import 'package:uuid/uuid.dart';

class MessageSearchScreen extends StatefulWidget {
  const MessageSearchScreen(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  final UserModel userModel;
  final User firebaseUser;

  @override
  _MessageSearchScreenState createState() => _MessageSearchScreenState();
}

class _MessageSearchScreenState extends State<MessageSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  Future<ChatRoomModel?> getChatroomModel(UserModel targetUser) async {
    ChatRoomModel? chatRoom;

    QuerySnapshot snapshot = await cloudFirestore
        .collection("ChatRooms")
        .where("participants.${widget.userModel.uId}", isEqualTo: true)
        .where("participants.${targetUser.uId}", isEqualTo: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Fetch the existing one
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatroom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);

      chatRoom = existingChatroom;
    } else {
      // Create a new one
      var uuid = const Uuid();
      ChatRoomModel newChatroom = ChatRoomModel(
        chatRoomId: uuid.v1(),
        lastMessage: "",
        participants: {
          widget.userModel.uId.toString(): true,
          targetUser.uId.toString(): true,
        },
      );

      await cloudFirestore
          .collection("ChatRooms")
          .doc(newChatroom.chatRoomId)
          .set(newChatroom.toMap());

      chatRoom = newChatroom;

      log("New Chatroom Created!");
    }

    return chatRoom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(labelText: "Email Address"),
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoButton(
                onPressed: () {
                  setState(() {});
                },
                color: Theme.of(context).colorScheme.secondary,
                child: const Text("Search"),
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder(
                  stream: cloudFirestore
                      .collection("Users")
                      .where("email", isEqualTo: _searchController.text)
                      .where("email", isNotEqualTo: widget.userModel.email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        QuerySnapshot dataSnapshot =
                            snapshot.data as QuerySnapshot;

                        if (dataSnapshot.docs.isNotEmpty) {
                          Map<String, dynamic> userMap = dataSnapshot.docs[0]
                              .data() as Map<String, dynamic>;

                          UserModel searchedUser = UserModel.fromMap(userMap);

                          return ListTile(
                            onTap: () async {
                              ChatRoomModel? chatRoomModel =
                                  await getChatroomModel(searchedUser);
                              if (chatRoomModel != null) {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ChatRoomScreen(
                                        targetUser: searchedUser,
                                        userModel: widget.userModel,
                                        chatRoomModel: chatRoomModel,
                                        firebaseUser: widget.firebaseUser,
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  searchedUser.profileImage.toString()),
                              backgroundColor: Colors.grey[500],
                            ),
                            title: Text(searchedUser.userName.toString()),
                            subtitle: Text(searchedUser.email!),
                            trailing: const Icon(Icons.keyboard_arrow_right),
                          );
                        } else {
                          return const Text("No results found!");
                        }
                      } else if (snapshot.hasError) {
                        return const Text("An error occured!");
                      } else {
                        return const Text("No results found!");
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
