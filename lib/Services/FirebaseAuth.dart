// FirebaseAuthService.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/Routes/AppRoutes.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Check if the user is currently signed in
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<User?> signInWithCredential(AuthCredential credential) async {
    try {
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print("Error during sign-in: $e");
      return null;
    }
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      print('Unknown error occurred: $e');
    }
    return null;
  }

  Future<void> logout() async {
    try {
      // Sign out from Google if the user is signed in with Google
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
      // Sign out from Firebase
      await _auth.signOut();

      // Navigate the user back to the splash screen or login screen
      Get.offAllNamed(AppRoutes.Signup); // Update the route as per your setup
    } catch (e) {
      print('Logout error: $e');
    }
  }

  void _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        Get.snackbar('SignUp Failed', 'Invalid email format.',
            snackPosition: SnackPosition.BOTTOM);
        break;
      case 'user-disabled':
        Get.snackbar('SignUp Failed', 'User has been disabled.',
            snackPosition: SnackPosition.BOTTOM);
        break;
      case 'user-not-found':
        Get.snackbar('SignUp Failed', 'No user found with this email.',
            snackPosition: SnackPosition.BOTTOM);
        break;
      case 'wrong-password':
        Get.snackbar('SignUp Failed', 'Wrong password provided.',
            snackPosition: SnackPosition.BOTTOM);
        break;
      case 'email-already-in-use':
        Get.snackbar('SignUp Failed', 'The email address is already in use by another account.',
            snackPosition: SnackPosition.BOTTOM);
        break;
      default:
        Get.snackbar('Error', e.message ?? 'An unknown error occurred',
            snackPosition: SnackPosition.BOTTOM);
    }
  }
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      print('Unknown error occurred: $e');
    }
    return null;
  }

  String? getUserName() {
    return _auth.currentUser?.displayName;
  }
}
