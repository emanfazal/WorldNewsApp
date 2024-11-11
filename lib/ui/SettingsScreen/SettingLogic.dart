import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Services/FirebaseAuth.dart';

import '../../Routes/AppRoutes.dart';

class SettingLogic extends GetxController{
  final FirebaseAuthService _auth= FirebaseAuthService();

  // Observable variable for the username
  RxString userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch the user's display name when the controller initializes
    userName.value = _auth.getUserName() ?? 'Guest';
  }
  Signout(){
  _auth.logout();
}
   showConfirmDialog(BuildContext context) {
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
                  Icons.error_outline,
                  color: Color(0xFF215273),
                  size: 80,
                ),
                SizedBox(height: 20),
                Text(
                  'Do You Really want to Logout!',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                // Text(
                //   'You have successfully created your account.',
                //   style: TextStyle(
                //     fontSize: 16,
                //     color: Colors.black,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                // Siz
                // edBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF215273),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                     // Navigate to the home screen
                  },
                  child: Text(
                    "No",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFCFF4D2),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF215273),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Signout();
                    // Close the dialog
                    // Get.offAllNamed(AppRoutes.home); // Navigate to the home screen
                  },
                  child: Text(
                    "Yes",
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
}