import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/contants.dart';
import 'package:tiktok_clone/controllers/comment_controller.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();
  CommentController commentController = Get.put(CommentController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updateVideoId(widget.id);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: commentController.comment.length,
                    itemBuilder: (context, index) {
                      final data = commentController.comment[index];
                      return ListTile(
                        leading: VxCircle(
                          radius: 40,
                          backgroundImage: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              data.profileImage.toString(),
                            ),
                          ),
                        ),
                        title: Row(
                          children: [
                            '${data.userName} '
                                .text
                                .size(20)
                                .bold
                                .color(primayColor!)
                                .make(),
                            data.comments!.text.size(20).color(Vx.white).make(),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            timeago
                                .format(data.commentDate!.toLocal())
                                .text
                                .sm
                                .make(),
                            10.widthBox,
                            '${data.likes!.length} likes'.text.sm.make(),
                          ],
                        ),
                        trailing: const Icon(
                          Icons.favorite_outline,
                          size: 20,
                        ),
                      );
                    },
                  );
                }),
              ),
              const Divider(),
              ListTile(
                title: TextFormField(
                  controller: _commentController,
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
                    onPressed: () =>
                        commentController.postComment(_commentController.text),
                    child: 'Send'.text.size(16).color(primayColor!).make()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
