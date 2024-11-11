import 'package:get/get.dart';

import 'OnboardingLogic.dart';

class OnBoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnBoardingLogic());
  }
}