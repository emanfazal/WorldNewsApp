import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../Routes/AppRoutes.dart';

class OnBoardingLogic extends GetxController {
  final pageController = PageController(viewportFraction: 1.0, keepPage: true);
  int currantPageIndex = 0;
  void goToSignupView() {
    Get.toNamed(AppRoutes.Signup);
  }
  @override
  void onInit() {
    super.onInit();
  }

  void onPageChanged(int value) {
    currantPageIndex = value;
    update(); // Notify listeners
  }

  String getButtonText() {
    return currantPageIndex == 2 ? 'Start' : 'Continue';
  }

  void onTapNext() {
    if (currantPageIndex == 2) {
      // Navigate to the next screen
      print('Navigating to the main screen...');
      // Example: Get.offNamed(AppRoutes.LoginIn);
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    }
  }
}
