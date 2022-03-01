import 'package:flutter/material.dart';
import 'package:tiktok_clone/contants.dart';
import 'package:velocity_x/velocity_x.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: VxCircle(
                        backgroundImage: const DecorationImage(
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1645963053554-30221fce7e6f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
                        ),
                      ),
                      title: Row(
                        children: [
                          'username'
                              .text
                              .size(20)
                              .bold
                              .color(primayColor!)
                              .make(),
                          'comments'.text.size(20).color(Vx.white).make(),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          'date'.text.sm.make(),
                          10.widthBox,
                          '0 likes'.text.sm.make(),
                        ],
                      ),
                      trailing: const Icon(
                        Icons.favorite_outline,
                        size: 20,
                      ),
                    );
                  },
                ),
              ),
              const Divider(),
              ListTile(
                title: TextFormField(
                  controller: commentController,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Comment',
                    labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                trailing: TextButton(
                    onPressed: () {}, child: 'Send'.text.size(16).make()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
