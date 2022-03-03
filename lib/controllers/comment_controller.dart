import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/contants.dart';
import 'package:tiktok_clone/models/comment_model.dart';

class CommentController extends GetxController {
  final Rx<List<CommentModel>> _comment = Rx<List<CommentModel>>([]);
  List<CommentModel> get comment => _comment.value;

  String _videoId = "";

  updateVideoId(String id) {
    _videoId = id;
    getComment();
  }

  getComment() async {
    _comment.bindStream(cloudFirestore
        .collection('Videos')
        .doc(_videoId)
        .collection('Comments')
        .snapshots()
        .map((QuerySnapshot query) {
      List<CommentModel> retValue = [];
      for (var element in query.docs) {
        retValue.add(CommentModel.fromSnap(element));
      }
      return retValue;
    }));
  }

  postComment(String commentText) async {
    try {
      DocumentSnapshot userDoc = await cloudFirestore
          .collection('Users')
          .doc(authController.user!.uid)
          .get();
      var allDoc = await cloudFirestore
          .collection('Videos')
          .doc(_videoId)
          .collection('Comments')
          .get();

      int len = allDoc.docs.length;
      CommentModel commentModel = CommentModel(
        commentId: 'Comment $len',
        comments: commentText.trim(),
        commentDate: DateTime.now(),
        uId: authController.user!.uid,
        userName: (userDoc.data() as dynamic)['userName'],
        profileImage: (userDoc.data() as dynamic)['profileImage'],
        likes: [],
      );
      await cloudFirestore
          .collection('Videos')
          .doc(_videoId)
          .collection('Comments')
          .doc('Comment $len')
          .set(commentModel.toJson());

      DocumentSnapshot doc =
          await cloudFirestore.collection('Videos').doc(_videoId).get();
      await cloudFirestore.collection('Videos').doc(_videoId).update({
        'commentsCount': (doc.data() as dynamic)['commentsCount'] + 1,
      });
    } catch (e) {
      Get.snackbar('Error: ', e.toString());
    }
  }

  likeComment(String id) async {
    var uId = authController.user!.uid;
    DocumentSnapshot documentSnapshot = await cloudFirestore
        .collection('Videos')
        .doc(_videoId)
        .collection('Comments')
        .doc(id)
        .get();

    if ((documentSnapshot.data() as dynamic)['likes'].contains(uId)) {
      cloudFirestore
          .collection('Videos')
          .doc(_videoId)
          .collection('Comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uId])
      });
    } else {
      cloudFirestore
          .collection('Videos')
          .doc(_videoId)
          .collection('Comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uId])
      });
    }
  }
}
