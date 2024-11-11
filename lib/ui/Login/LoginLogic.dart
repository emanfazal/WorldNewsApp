import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/Utils/Assets/Constants.dart';

import '../../Routes/AppRoutes.dart';
import '../../Services/FirebaseAuth.dart';

class LoginLogic extends GetxController{
  final FirebaseAuthService _auth = FirebaseAuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isShowProgress = false;
  bool isShowPassword = true;
 signIn() async {

    if (formKey.currentState?.validate() ?? false) {
      String email = emailController.text;
      String password = passwordController.text;

      try {
        User? user = await _auth.signInWithEmailAndPassword(email, password);
        if (user != null) {
          print('User is successfully logged in');
          Get.offAllNamed(AppRoutes.home); // Navigate to home after successful login
        }
      } on FirebaseAuthException catch (e) {
        print('Login failed: ${e.message}');
        Get.snackbar('Login Failed', e.message ?? 'An error occurred',
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }
  String? isPasswordValid(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
  String? isEmailValid(String email) {
    if (email.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  void toggleShowHidePassword() {
    isShowPassword = !isShowPassword;
    update([Constant.idPasswordInput]);
  }
void gotoSignUp(){
  Get.toNamed(AppRoutes.Signup);

}
  signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        await _auth.signInWithCredential(credential);
      }
    } catch (e) {
      print('Some error occurred during Google sign-in: $e');
    }
  }
}