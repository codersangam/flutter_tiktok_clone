import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? commentId;
  String? comments;
  DateTime? commentDate;
  String? uId;
  String? userName;
  String? profileImage;
  List? likes;

  CommentModel(
      {this.commentId,
      this.comments,
      this.commentDate,
      this.uId,
      this.userName,
      this.profileImage,
      this.likes});

  Map<String, dynamic> toJson() => {
        'commentId': commentId,
        'comments': comments,
        'commentDate': commentDate,
        'uId': uId,
        'userName': userName,
        'profileImage': profileImage,
        'likes': likes
      };

  static CommentModel fromSnap(DocumentSnapshot documentSnapshot) {
    var snap = documentSnapshot.data() as Map<String, dynamic>;
    return CommentModel(
      commentId: snap['commentId'],
      comments: snap['comments'],
      commentDate: snap['commentDate'].toDate(),
      uId: snap['uId'],
      userName: snap['userName'],
      profileImage: snap['profileImage'],
      likes: snap['likes'],
    );
  }
}
