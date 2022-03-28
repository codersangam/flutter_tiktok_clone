import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/models/video_model.dart';

class VideosAPI {
  List<VideoModel> videoList = <VideoModel>[];

  VideosAPI() {
    load();
  }

  void load() async {
    videoList = await getVideoList();
  }

  Future<List<VideoModel>> getVideoList() async {
    var data = await FirebaseFirestore.instance.collection("Videos").get();

    var videoList = <VideoModel>[];
    // ignore: prefer_typing_uninitialized_variables
    var videos;

    if (data.docs.isEmpty) {
      // await addDemoData();
      videos = (await FirebaseFirestore.instance.collection("Videos").get());
    } else {
      videos = data;
    }

    videos.docs.forEach((element) {
      VideoModel video = VideoModel.fromJson(element.data());
      videoList.add(video);
    });

    return videoList;
  }
}
