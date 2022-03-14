import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/contants.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});

  Map<String, dynamic> get user => _user.value;

  final Rx<String> _uId = "".obs;

  updateUserId(String id) {
    _uId.value = id;
    getUserData();
  }

  getUserData() async {
    List<String> thumbnail = [];
    var videoDoc = await cloudFirestore
        .collection('Videos')
        .where('uId', isEqualTo: _uId.value)
        .get();

    for (int i = 0; i < videoDoc.docs.length; i++) {
      thumbnail.add((videoDoc.docs[i].data() as dynamic)['thumbnail']);
    }

    DocumentSnapshot userDoc =
        await cloudFirestore.collection('Users').doc(_uId.value).get();
    final userData = userDoc.data() as dynamic;
    String userName = userData['userName'];
    String profileImage = userData['profileImage'];
    int? follower = 0;
    int? following = 0;
    int likes = 0;
    bool isFollowing = false;

    for (var item in videoDoc.docs) {
      likes += (item.data()['likes'] as List).length;
    }

    var followerDoc = await cloudFirestore
        .collection('Users')
        .doc(_uId.value)
        .collection('Followers')
        .get();
    var followingDoc = await cloudFirestore
        .collection('Users')
        .doc(_uId.value)
        .collection('Following')
        .get();

    follower = followerDoc.docs.length;
    following = followingDoc.docs.length;

    cloudFirestore
        .collection('Users')
        .doc(_uId.value)
        .collection('Followers')
        .doc(authController.user?.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

    _user.value = {
      'followers': follower.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
      'likes': likes.toString(),
      'profileImage': profileImage,
      'userName': userName,
      'thumbnail': thumbnail,
    };
    update();
  }

  followUser() async {
    var doc = await cloudFirestore
        .collection('Users')
        .doc(_uId.value)
        .collection('Followers')
        .doc(authController.user!.uid)
        .get();

    if (!doc.exists) {
      await cloudFirestore
          .collection('Users')
          .doc(_uId.value)
          .collection('Followers')
          .doc(authController.user!.uid)
          .set({});
      await cloudFirestore
          .collection('Users')
          .doc(authController.user!.uid)
          .collection('Following')
          .doc(_uId.value)
          .set({});

      _user.value.update(
        'followers',
        (value) => (int.parse(value) + 1).toString(),
      );
    } else {
      await cloudFirestore
          .collection('Users')
          .doc(_uId.value)
          .collection('Followers')
          .doc(authController.user!.uid)
          .delete();
      await cloudFirestore
          .collection('Users')
          .doc(authController.user!.uid)
          .collection('Following')
          .doc(_uId.value)
          .delete();

      _user.value.update(
        'followers',
        (value) => (int.parse(value) - 1).toString(),
      );
    }
    _user.value.update('isFollowing', (value) => !value);
    update();
  }
}
