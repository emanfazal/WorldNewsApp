import 'package:get/get.dart';
import 'package:news_app/ui/Login/LoginLogic.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>LoginLogic());
  }
}