import 'package:get/get.dart';
import 'package:news_app/ui/Description/DescriptionLogic.dart';

class DescriptionBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DescriptionLogic>(() => DescriptionLogic());
  }

}