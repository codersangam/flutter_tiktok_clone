import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:tiktok_clone/controllers/video_controller.dart';
import 'package:video_player/video_player.dart';
import '../../models/video_model.dart';
import '../widgets/actions_toolbar.dart';
import '../widgets/video_description.dart';
import 'feed_viewmodel.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final locator = GetIt.instance;
  final VideoController videoController = Get.put(VideoController());
  final feedViewModel = GetIt.instance<FeedViewModel>();
  @override
  void initState() {
    feedViewModel.loadVideo(0);
    feedViewModel.loadVideo(1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedViewModel>.reactive(
        disposeViewModel: false,
        builder: (context, model, child) => videoScreen(),
        viewModelBuilder: () => feedViewModel);
  }

  Widget videoScreen() {
    return Scaffold(
      backgroundColor: GetIt.instance<FeedViewModel>().actualScreen == 0
          ? Colors.black
          : Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: PageController(
              initialPage: 0,
              viewportFraction: 1,
            ),
            itemCount: feedViewModel.videoSource?.videoList.length,
            onPageChanged: (index) {
              index = index % (feedViewModel.videoSource!.videoList.length);
              feedViewModel.changeVideo(index);
            },
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              index = index % (feedViewModel.videoSource!.videoList.length);
              return videoCard(feedViewModel.videoSource!.videoList[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget videoCard(VideoModel video) {
    return Stack(
      children: [
        video.controller != null
            ? SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: video.controller?.value.size.width ?? 0,
                    height: video.controller?.value.size.height ?? 0,
                    child: VideoPlayer(video.controller!),
                  ),
                ),
              )
            : Container(
                color: Colors.black,
                child: const Center(
                  child: Text("Loading"),
                ),
              ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                VideoDescription(
                    video.userName, video.songName, video.songName),
                ActionsToolbar(
                    video.likes.toString(),
                    video.commentsCount.toString(),
                    video.profileImage.toString()),
              ],
            ),
            const SizedBox(height: 20)
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    feedViewModel.controller?.dispose();
    super.dispose();
  }
}
