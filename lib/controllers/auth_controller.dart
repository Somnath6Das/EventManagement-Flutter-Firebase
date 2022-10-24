import 'package:event_management/views/home_screen.dart';
import 'package:event_management/views/profile_screen.dart';
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
      Get.to(() => const HomeScreen());
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
      Get.to(() => const ProfileScreen());
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
      Get.to(() => const HomeScreen());
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
}
