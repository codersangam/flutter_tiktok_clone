import 'package:cloud_firestore/cloud_firestore.dart';

class FollowModel {
  String? followId;
  DateTime? followedDate;
  String? uId;
  String? userName;
  String? profileImage;

  FollowModel(
      {this.followId,
      this.followedDate,
      this.uId,
      this.userName,
      this.profileImage});

  Map<String, dynamic> toJson() => {
        'followId': followId,
        'followedDate': followedDate,
        'uId': uId,
        'userName': userName,
        'profileImage': profileImage
      };

  static FollowModel fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return FollowModel(
      followId: snap['followId'],
      followedDate: snap['followedDate'].toDate(),
      uId: snap['uId'],
      userName: snap['userName'],
      profileImage: snap['profileImage'],
    );
  }
}
