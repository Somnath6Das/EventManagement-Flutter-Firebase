import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/views/bottom_bar_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:event_management/views/home_screen.dart';
import 'package:event_management/views/add_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  var isLoading = false.obs;

  void login({String? email, String? password}) {
    isLoading(true);
    auth
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      isLoading(false);
      Get.to(() => const BottomBarView());
    }).catchError((e) {
      isLoading(false);
      Get.snackbar(
          'Error in signing', 'Please write current email and password.');
    });
  }

  void signUp({String? email, String? password}) {
    isLoading(true);
    auth
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      isLoading(false);
      Get.to(() => const AddProfileScreen());
    }).catchError((e) {
      isLoading(false);
      Get.snackbar('Error in signup', '$e');
    });
  }

  signInWithGoogle() async {
    isLoading(true);
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      isLoading(false);
      Get.to(() => const BottomBarView());
    }).catchError((e) {
      isLoading(false);
      Get.snackbar('Error', 'Google login error');
    });
  }

  void forgetPassword(String email) {
    auth.sendPasswordResetEmail(email: email).then((value) {
      Get.back();
      Get.snackbar('Email Sent', 'We have send password reset email.');
    }).catchError((e) {
      Get.snackbar('Error', 'Error while sending password reset email');
    });
  }

    var isProfileInformationLoading = false.obs;

    Future<String> uploadImageToFirebaseStorage(File image) async {
    String imageUrl = '';
    String fileName = Path.basename(image.path);

    var reference =
        FirebaseStorage.instance.ref().child('profileImages/$fileName');
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value) {
      imageUrl = value;
    }).catchError((e) {
      Get.snackbar('Error', 'Can not upload profile image');
    });

    return imageUrl;
  }

 

  uploadProfileData(String imageUrl, String firstName, String lastName,
      String mobileNumber, String dob, String gender) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'imageUrl': imageUrl,
      'firstName': firstName,
      'lastName': lastName,
      'mobileNumber': mobileNumber,
      'dob': dob,
      'gender': gender
    }).then((value) {
      isProfileInformationLoading(false);
      Get.offAll(() => const BottomBarView());
    });
  }
}
