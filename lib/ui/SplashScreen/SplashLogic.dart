import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../Routes/AppRoutes.dart';

class SplashScreenLogic extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    Get.offAllNamed(AppRoutes.Onboarding);// This will navigate to the home screen and remove the splash screen from the stack
  }
}
