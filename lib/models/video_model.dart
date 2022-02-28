import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  String? uId;
  String? userName;
  String? profileImage;
  String? videoId;
  String? videoPath;
  List? likes;
  int? commentsCount;
  int? shareCount;
  String? songName;
  String? caption;
  String? thumbnail;

  VideoModel(
      {this.uId,
      this.userName,
      this.profileImage,
      this.videoId,
      this.videoPath,
      this.likes,
      this.commentsCount,
      this.shareCount,
      this.songName,
      this.caption,
      this.thumbnail});

  Map<String, dynamic> toJson() => {
        "uId": uId,
        "userName": userName,
        "profileImage": profileImage,
        "videoId": videoId,
        "videoPath": videoPath,
        "likes": likes,
        "commentsCount": commentsCount,
        "shareCount": shareCount,
        "songName": songName,
        "caption": caption,
        "thumbnail": thumbnail
      };

  static VideoModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return VideoModel(
      uId: snapshot["uId"],
      userName: snapshot["userName"],
      profileImage: snapshot["profileImage"],
      videoId: snapshot["videoId"],
      videoPath: snapshot["videoPath"],
      likes: snapshot["likes"],
      commentsCount: snapshot["commentsCount"],
      shareCount: snapshot["shareCount"],
      songName: snapshot["songName"],
      caption: snapshot["caption"],
      thumbnail: snapshot["thumbnail"],
    );
  }
}
