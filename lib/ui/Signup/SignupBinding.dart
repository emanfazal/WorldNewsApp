import 'package:get/get.dart';
import 'package:news_app/ui/Signup/SignupLogic.dart';



class Signupbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupLogic());
  }
}