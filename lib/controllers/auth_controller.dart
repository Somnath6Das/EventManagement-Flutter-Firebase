import 'dart:math';

import 'package:event_management/views/home_screen.dart';
import 'package:event_management/views/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

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
      print('Error in signin $e');
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
      print('Error in signUp $e');
    });
  }
}
