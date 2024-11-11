// SignupLogic.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/Routes/AppRoutes.dart';

import '../../Services/FirebaseAuth.dart';
import '../../Utils/Assets/Constants.dart';

class SignupLogic extends GetxController {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isShowProgress = false;
  bool isShowPassword = true;

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

  signUp() async {
    if (formKey.currentState?.validate() ?? false) {
      String email = emailController.text;
      String password = passwordController.text;

      try {
        User? user = await _auth.signUpWithEmailAndPassword(email, password);
        if (user != null) {
          print('User is successfully signed up');
          showCongratulationsDialog(Get.context!); // Show the dialog
        }
      } catch (e) {
        print('SignUp failed: ${e}');
      }
    }
  }


  String? isEmailValid(String email) {
    if (email.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? isNameValid(String name) {
    if (name.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? isPasswordValid(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void toggleShowHidePassword() {
    isShowPassword = !isShowPassword;
    update([Constant.idPasswordInput]);
  }
  void showCongratulationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Color(0xFFCFF4D2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Color(0xFF215273),
                  size: 80,
                ),
                SizedBox(height: 20),
                Text(
                  'CONGRATULATIONS!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'You have successfully created your account.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF215273),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Get.offAllNamed(AppRoutes.home); // Navigate to the home screen
                  },
                  child: Text(
                    "Let's Get Started",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFCFF4D2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
void gotoLogin(){
  Get.toNamed(AppRoutes.Login);
}
}
