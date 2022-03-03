import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/contants.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primayColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.person_add_alt_1_outlined),
        ),
        title: 'Tuk Tuk'.text.make(),
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
                                imageUrl:
                                    'https://images.unsplash.com/photo-1646168421491-2ce10316242f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=812&q=80',
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            10.heightBox,
                            '@userName'.text.bold.make(),
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
                          '800'.text.bold.xl.make(),
                          8.heightBox,
                          'Following'.text.fontWeight(FontWeight.w400).make(),
                        ],
                      ),
                      Column(
                        children: [
                          '800'.text.bold.xl.make(),
                          8.heightBox,
                          'Fans'.text.fontWeight(FontWeight.w400).make(),
                        ],
                      ),
                      Column(
                        children: [
                          '800'.text.bold.xl.make(),
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
                      onTap: () {},
                      child: 'Sign Out'.text.bold.makeCentered(),
                    ),
                  ),
                  //* Videos List
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
