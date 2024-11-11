import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/ui/Category/CategoryLogic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryView extends StatelessWidget {
  CategoryView({super.key});

  final CategoryLogic controller = Get.find<CategoryLogic>();

  final List<String> categoriesList = [
    'General', 'Business', 'Entertainment', 'Health', 'Science', 'Sports', 'Technology'
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Center(
          child: Text(
            'Top Headlines',
            style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20 ,vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoriesList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.updateCategory(categoriesList[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Container(
                            decoration: BoxDecoration(
                              color: controller.category.value == categoriesList[index]
                                  ? const Color(0xFFCFF4D2)
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  categoriesList[index],
                                  style: GoogleFonts.poppins(
                                    color: controller.category.value == categoriesList[index]
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Display articles
                if (controller.newsHeadlines.value?.articles != null &&
                    controller.newsHeadlines.value!.articles!.isNotEmpty) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.02),
                    child: Column(
                      children: List.generate(controller.newsHeadlines.value!.articles!.length, (index) {
                        final article = controller.newsHeadlines.value!.articles![index];
                        DateTime dateTime = DateTime.parse(article.publishedAt.toString());

                        return InkWell(
                          // onTap: () => controller.goToDescriptionView(index),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            color:  Color(0xFFCFF4D2),
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                // Image Section
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: article.urlToImage ?? '',
                                    height: height * 0.2,
                                    width: width * 0.3,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) => Container(
                                      color: Colors.grey[300],
                                      height: height * 0.2,
                                      width: width * 0.3,
                                      child: Center(
                                        child: Text(
                                          'No Image',
                                          style: TextStyle(color: Colors.grey[700]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10), // Space between image and title

                                // Title and Date Section
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.title ?? 'No title available',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4), // Space between title and date
                                      Text(
                                        "${dateTime.day}/${dateTime.month}/${dateTime.year}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ] else
                  Center(
                    child: SpinKitFadingCircle(color: Colors.blue, size: 40),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
