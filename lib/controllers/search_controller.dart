import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/contants.dart';
import 'package:tiktok_clone/models/user_model.dart';

class SearchUserController extends GetxController {
  final Rx<List<UserModel>> _searchedUsers = Rx<List<UserModel>>([]);
  List<UserModel> get searchedUsers => _searchedUsers.value;

  searchUsers(String typedUser) async {
    _searchedUsers.bindStream(cloudFirestore
        .collection('Users')
        .where('userName', isGreaterThanOrEqualTo: typedUser)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      List<UserModel> retValue = [];
      for (var element in snapshot.docs) {
        retValue.add(UserModel.fromSnap(element));
      }
      return retValue;
    }));
  }
}
