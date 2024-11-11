import 'package:get/get.dart';
import 'package:news_app/Models/NewsChannelHeadlinesModel.dart';
import 'package:news_app/Models/NewsViewModel.dart';
import 'package:news_app/ui/Category/CategoryView.dart';

import '../../Routes/AppRoutes.dart';
import '../Category/CategoryBinding.dart';
import '../Description/DescriptionView.dart';

class HomeLogic extends GetxController {
  final NewsViewModel newsViewModel = NewsViewModel();
  var selectedFilter = 'bbc-news'.obs;
  var newsHeadlines = Rx<NewsChannelsHeadlinesModel?>(null);

  @override
  void onInit() {
    fetchNewsHeadlines();
    super.onInit();
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    fetchNewsHeadlines();
  }

  Future<void> fetchNewsHeadlines() async {
    newsHeadlines.value = await newsViewModel.fetchNewsChannelHeadlinesApi(selectedFilter.value);
  }

  void goToCategoryView() {
    Get.to(() => CategoryView(), binding: CategoryBinding());
  }

  void goToSettingsView() {
    Get.toNamed(AppRoutes.Settings);
  }

  void goToDescriptionView(int index) {
    Get.toNamed(AppRoutes.description, arguments: index);  }

  var hoveredIndex = (-1).obs;
}
