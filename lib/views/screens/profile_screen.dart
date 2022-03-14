import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/contants.dart';
import 'package:tiktok_clone/controllers/profile_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.uId}) : super(key: key);

  final String uId;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    profileController.updateUserId(widget.uId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        if (controller.user.isEmpty) {
          return Center(
            child: CircularProgressIndicator(
              color: primayColor,
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primayColor,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person_add_alt_1_outlined),
            ),
            title: 'Cryptogram'.text.make(),
            actions: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.calendar_month),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu),
                  ),
                ],
              )
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  ClipOval(
                                    child: CachedNetworkImage(
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      imageUrl: controller.user['profileImage'],
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              CircularProgressIndicator(
                                        value: downloadProgress.progress,
                                        color: primayColor,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  10.heightBox,
                                  '@${controller.user['userName']}'
                                      .toString()
                                      .text
                                      .bold
                                      .make(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        25.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                '${controller.user['following']}'
                                    .text
                                    .bold
                                    .xl
                                    .make(),
                                8.heightBox,
                                'Following'
                                    .text
                                    .fontWeight(FontWeight.w400)
                                    .make(),
                              ],
                            ),
                            Column(
                              children: [
                                controller.user['followers']
                                    .toString()
                                    .text
                                    .bold
                                    .xl
                                    .make(),
                                8.heightBox,
                                'Followers'
                                    .text
                                    .fontWeight(FontWeight.w400)
                                    .make(),
                              ],
                            ),
                            Column(
                              children: [
                                '${controller.user['likes']}'
                                    .text
                                    .bold
                                    .xl
                                    .make(),
                                8.heightBox,
                                'Likes'.text.fontWeight(FontWeight.w400).make(),
                              ],
                            ),
                          ],
                        ),
                        25.heightBox,
                        Container(
                          height: 50,
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.white),
                          ),
                          child: InkWell(
                            onTap: () {
                              if (widget.uId == authController.user!.uid) {
                                authController.signOut();
                              } else {
                                controller.followUser();
                              }
                            },
                            child: Center(
                              child: Text(
                                widget.uId == authController.user!.uid
                                    ? 'Sign Out'
                                    : controller.user['isFollowing']
                                        ? 'Unfollow'
                                        : 'Follow',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        25.heightBox,
                        //* Videos List
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.user['thumbnail'].length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5),
                          itemBuilder: (context, index) {
                            String data = controller.user['thumbnail'][index];
                            return CachedNetworkImage(
                              imageUrl: data,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
