import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/search_controller.dart';
import 'package:tiktok_clone/models/user_model.dart';
import 'package:tiktok_clone/views/screens/profile_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../contants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchUserController searchUserController = Get.put(SearchUserController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: TextFormField(
              decoration: const InputDecoration(
                filled: false,
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onFieldSubmitted: (value) =>
                  searchUserController.searchUsers(value),
            ),
          ),
          body: searchUserController.searchedUsers.isEmpty
              ? 'Search Users'.text.makeCentered()
              : ListView.builder(
                  itemCount: searchUserController.searchedUsers.length,
                  itemBuilder: (context, index) {
                    UserModel user = searchUserController.searchedUsers[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              uId: user.uId.toString(),
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: VxCircle(
                          radius: 40,
                          backgroundImage: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              user.profileImage.toString(),
                            ),
                          ),
                        ),
                        title: Row(
                          children: [
                            '${user.userName} '
                                .text
                                .size(20)
                                .bold
                                .color(primayColor!)
                                .make(),
                            // data.comments!.text.size(20).color(Vx.white).make(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
