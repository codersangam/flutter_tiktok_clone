import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/contants.dart';
import 'package:tiktok_clone/helper/firebase_helper.dart';
import 'package:tiktok_clone/models/user_model.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  Map<String, dynamic>? userMap;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User? currentUser = firebaseAuth.currentUser;
    userModel() async {
      UserModel? thisUserModel =
          await FirebaseHelper.getUserModelById(currentUser!.uid);
      return thisUserModel!.email;
    }

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
                      .where("email", isNotEqualTo: userModel.toString())
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
