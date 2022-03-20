import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/contants.dart';
import 'package:tiktok_clone/helper/firebase_helper.dart';
import 'package:tiktok_clone/views/screens/messages/chat_room_screen.dart';
import 'package:tiktok_clone/views/screens/messages/message_search_screen.dart';

import '../../../models/chat_room_model.dart';
import '../../../models/user_model.dart';

class MessageHomeScreen extends StatelessWidget {
  const MessageHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: cloudFirestore
              .collection("ChatRooms")
              .where("participants.${authController.user!.uid}",
                  isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                QuerySnapshot chatRoomSnapshot = snapshot.data as QuerySnapshot;

                return ListView.builder(
                  itemCount: chatRoomSnapshot.docs.length,
                  itemBuilder: (context, index) {
                    ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                        chatRoomSnapshot.docs[index].data()
                            as Map<String, dynamic>);

                    Map<String, dynamic> participants =
                        chatRoomModel.participants!;

                    List<String> participantKeys = participants.keys.toList();
                    participantKeys.remove(authController.user!.uid);

                    return FutureBuilder(
                      future:
                          FirebaseHelper.getUserModelById(participantKeys[0]),
                      builder: (context, userData) {
                        if (userData.connectionState == ConnectionState.done) {
                          if (userData.data != null) {
                            UserModel targetUser = userData.data as UserModel;

                            return ListTile(
                              onTap: () async {
                                UserModel? thisUserModel =
                                    await FirebaseHelper.getUserModelById(
                                        currentUser!.uid);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return ChatRoomScreen(
                                      chatRoomModel: chatRoomModel,
                                      firebaseUser: currentUser,
                                      userModel: thisUserModel!,
                                      targetUser: targetUser,
                                    );
                                  }),
                                );
                              },
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    targetUser.profileImage.toString()),
                              ),
                              title: Text(targetUser.userName.toString()),
                              subtitle: (chatRoomModel.lastMessage.toString() !=
                                      "")
                                  ? Text(chatRoomModel.lastMessage.toString())
                                  : Text(
                                      "Say hi to your new friend!",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                            );
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return const Center(
                  child: Text("No Chats"),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
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
                firebaseUser: currentUser,
              ),
            ),
          );
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
