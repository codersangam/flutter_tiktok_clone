import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';
import '../../controllers/video_controller.dart';

class FeedViewModel extends BaseViewModel {
  VideoPlayerController? controller;
  // VideosAPI? videoSource;
  VideoController? videoSource;

  int prevVideo = 0;

  int actualScreen = 0;

  FeedViewModel() {
    videoSource = Get.put(VideoController());
    // videoSource = VideosAPI();
  }

  changeVideo(index) async {
    if (videoSource!.videoList[index].controller == null) {
      await videoSource!.videoList[index].loadController();
    }
    videoSource!.videoList[index].controller!.play();
    //videoSource.listVideos[prevVideo].controller.removeListener(() {});

    if (videoSource!.videoList[prevVideo].controller != null) {
      videoSource!.videoList[prevVideo].controller!.pause();
    }

    prevVideo = index;
    notifyListeners();

    // ignore: avoid_print
    print(index);
  }

  void loadVideo(int index) async {
    if (videoSource!.videoList.length > index) {
      await videoSource!.videoList[index].loadController();
      videoSource!.videoList[index].controller?.play();
      notifyListeners();
    }
  }

  void setActualScreen(index) {
    actualScreen = index;
    if (index == 0) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    notifyListeners();
  }
}
