import 'package:get/get.dart';
import 'package:news_app/ui/HomeScreen/HomeLogic.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeLogic());
  }
}
