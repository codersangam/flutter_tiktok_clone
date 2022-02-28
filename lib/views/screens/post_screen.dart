import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/contants.dart';
import 'package:tiktok_clone/views/screens/confirm_post_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    // ignore: unnecessary_null_comparison
    if (video != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PostConfirmScreen(
            videoFile: File(video.path),
            videoPath: video.path,
          ),
        ),
      );
    }
  }

  showDialogOptions(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.gallery, context),
            child: Row(
              children: [
                const Icon(Icons.image),
                const Text('Gallery').p(8),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.camera, context),
            child: Row(
              children: [
                const Icon(Icons.camera),
                const Text('Camera').p(8),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                const Icon(Icons.cancel),
                const Text('Cancel').p(8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 50,
          width: 150,
          child: ElevatedButton(
            onPressed: () => showDialogOptions(context),
            child: 'Add Video'.text.make(),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(primayColor)),
          ),
        ),
      ),
    );
  }
}
