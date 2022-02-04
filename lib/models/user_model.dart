import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uId;
  String? userName;
  String? email;
  String? profileImage;

  UserModel({this.uId, this.userName, this.email, this.profileImage});

  Map<String, dynamic> toJson() => {
        'uId': uId,
        'userName': userName,
        'email': email,
        'profileImage': profileImage
      };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      uId: snapshot['uId'],
      userName: snapshot['userName'],
      email: snapshot['email'],
      profileImage: snapshot['profileImage'],
    );
  }
}
