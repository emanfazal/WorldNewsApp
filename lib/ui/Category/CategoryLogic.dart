import 'package:get/get.dart';

import '../../Models/CategoriesModel.dart';
import '../../Models/NewsViewModel.dart';
import '../../Routes/AppRoutes.dart';

class CategoryLogic extends GetxController {
  final NewsViewModel newsViewModel = NewsViewModel();
  var category = 'general'.obs; // Initialize with a default category
  var newsHeadlines = Rx<Categories?>(null);

  @override
  void onInit() {
    // Fetch headlines for the default category on initialization
    fetchHeadlines(category.value);

  }
  void goToDescriptionView(int index) {
    Get.toNamed(AppRoutes.description, arguments: index);
  }
  void updateCategory(String newCategory) {
    category.value = newCategory.toLowerCase(); // Update the category
    fetchHeadlines(category.value);
    category.value = newCategory;// Fetch new headlines based on the selected category
  }

  void fetchHeadlines(String category) async {
    newsHeadlines.value = await newsViewModel.fetchNewsCategoriesApi(category);
  }
}
