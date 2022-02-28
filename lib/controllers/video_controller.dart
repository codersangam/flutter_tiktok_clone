import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/contants.dart';
import 'package:tiktok_clone/models/video_model.dart';

class VideoController extends GetxController {
  final Rx<List<VideoModel>> _videoList = Rx<List<VideoModel>>([]);
  List<VideoModel> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(
      cloudFirestore.collection('Videos').snapshots().map(
        (QuerySnapshot querySnapshot) {
          List<VideoModel> returnValue = [];
          for (var element in querySnapshot.docs) {
            returnValue.add(VideoModel.fromSnap(element));
          }
          return returnValue;
        },
      ),
    );
  }
}
