import 'package:get/get.dart';
import 'package:news_app/ui/Category/CategoryLogic.dart';

class CategoryBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CategoryLogic>(() => CategoryLogic());
  }
}