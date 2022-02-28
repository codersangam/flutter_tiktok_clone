import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/upload_video_controller.dart';
import 'package:tiktok_clone/views/widgets/custom_text_field.dart';
import 'package:video_player/video_player.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../contants.dart';

class PostConfirmScreen extends StatefulWidget {
  const PostConfirmScreen(
      {Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);

  final File videoFile;
  final String videoPath;

  @override
  State<PostConfirmScreen> createState() => _PostConfirmScreenState();
}

class _PostConfirmScreenState extends State<PostConfirmScreen> {
  late VideoPlayerController controller;
  TextEditingController songController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
      controller.initialize();
      controller.play();
      controller.setVolume(0.5);
      controller.setLooping(true);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            30.heightBox,
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: VideoPlayer(controller),
            ),
            30.heightBox,
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: CustomTextField(
                        labelText: 'Song Name',
                        controller: songController,
                        icon: Icons.music_note),
                  ),
                  10.heightBox,
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: CustomTextField(
                        labelText: 'Caption',
                        controller: captionController,
                        icon: Icons.closed_caption),
                  ),
                  30.heightBox,
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => uploadVideoController.uploadVideo(
                          songController.text,
                          captionController.text,
                          widget.videoPath),
                      child: 'Publish'.text.lg.bold.make(),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(primayColor),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
