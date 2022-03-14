import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/contants.dart';
import 'package:tiktok_clone/models/user_model.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';
import 'package:tiktok_clone/views/screens/login_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  // Check user logged In or not?
  late Rx<User?> _user;

  User? get user => _user.value;

  var isLoading = false.obs;

  var isPasswordHidden = true.obs;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.userChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  // late Rx<File?> _pickedImage;
  // File? get profileImage => _pickedImage.value;

  var selectedImage = "".obs;

  // Pick an Image
  pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      selectedImage.value = pickedImage.path;
      Get.snackbar('Profile Image', 'Avatar selected successfully');
    } else {
      Get.snackbar('Error: ', 'No Image selected');
    }
    // _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  // Upload Image to Storage
  _uploadImageToStorage(File image) async {
    Reference reference = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // Register User
  void registerUser(
      String userName, String email, String password, File? image) async {
    isLoading.value = true;
    try {
      if (userName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential userCredential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);

        String downloadUrl = await _uploadImageToStorage(image);

        UserModel userModel = UserModel(
          userName: userName,
          email: email,
          uId: userCredential.user!.uid,
          profileImage: downloadUrl,
        );
        await cloudFirestore
            .collection('Users')
            .doc(userCredential.user!.uid)
            .set(userModel.toJson());
      } else {
        Get.snackbar(
          'Required',
          'All Fields are required.',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error: ',
        e.toString(),
      );
    }
    isLoading.value = false;
  }

  // Login User
  void loginUser(String email, String password) async {
    isLoading.value = true;
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        Get.snackbar(
          'Required',
          'All Fields are required.',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error: ',
        e.toString(),
      );
    }
    isLoading.value = false;
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }

  googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      // ignore: avoid_print
      print("signed in " + user!.displayName.toString());

      UserModel userModel = UserModel(
        userName: user.displayName,
        email: user.email,
        uId: user.uid,
        profileImage: user.photoURL,
      );
      await cloudFirestore
          .collection('Users')
          .doc(user.uid)
          .set(userModel.toJson());

      return user;
      // ignore: empty_catches

    } catch (e) {
      Get.snackbar(
        'Error: ',
        e.toString(),
      );
    }
  }
}
