import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:tiktok_clone/contants.dart';
import 'package:tiktok_clone/models/video_model.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  var isLoading = false.obs;
  // Compress Video
  _compressedVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;
  }

  // Upload Video To Storage
  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference reference = firebaseStorage.ref().child('Videos').child(id);
    UploadTask uploadTask =
        reference.putFile(await _compressedVideo(videoPath));
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videpPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videpPath);
    var croppedImage = await ImageCropper().cropImage(
        sourcePath: thumbnail.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 20);
    return croppedImage;
  }

  // Upload Thumbnail To Storage
  Future<String> _uploadThumbnailToStorage(String id, String videoPath) async {
    Reference reference = firebaseStorage.ref().child('Thumbnails').child(id);
    UploadTask uploadTask = reference.putFile(await _getThumbnail(videoPath));
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadVideo(String songName, String caption, String videoPath) async {
    isLoading.value = true;
    try {
      // get userdata
      String uId = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userData =
          await cloudFirestore.collection('Users').doc(uId).get();

      // get video data
      var videoData = await cloudFirestore.collection('Videos').get();
      int len = videoData.docs.length;
      String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);

      // Thumbnail
      String thumbnailUrl =
          await _uploadThumbnailToStorage("Video $len", videoPath);

      VideoModel videoModel = VideoModel(
        userName: (userData.data()! as Map<String, dynamic>)['userName'],
        uId: uId,
        profileImage:
            (userData.data()! as Map<String, dynamic>)['profileImage'],
        videoId: "Video $len",
        videoPath: videoUrl,
        likes: [],
        commentsCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        thumbnail: thumbnailUrl,
        videoPostDate: DateTime.now(),
      );
      await cloudFirestore
          .collection('Videos')
          .doc('Video $len')
          .set(videoModel.toJson());
      Get.back();
    } catch (e) {
      Get.snackbar('Error: ', e.toString());
    }
    isLoading.value = false;
  }
}
