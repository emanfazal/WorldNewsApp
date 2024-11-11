import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:news_app/ui/HomeScreen/HomeLogic.dart';
import '../../generated/assets.dart';

enum FilterList { bbcnews, ESPN, al_jazeera_english, cnn }

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final controller = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final format = DateFormat('MMMM dd, yyyy');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: PopupMenuButton(
          icon: Icon(Icons.filter_list, color: Color(0xFFCFF4D2)),
          onSelected: (FilterList item) {
            switch (item) {
              case FilterList.bbcnews:
                controller.setFilter('bbc-news');
                break;
              case FilterList.ESPN:
                controller.setFilter('espn');
                break;
              case FilterList.al_jazeera_english:
                controller.setFilter('al-jazeera-english');
                break;
              case FilterList.cnn:
                controller.setFilter('cnn');
                break;
            }
          },
          itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
            PopupMenuItem(value: FilterList.bbcnews, child: Text('BBC News')),
            PopupMenuItem(value: FilterList.ESPN, child: Text('ESPN')),
            PopupMenuItem(value: FilterList.al_jazeera_english, child: Text('Al-Jazeera')),
            PopupMenuItem(value: FilterList.cnn, child: Text('CNN')),
          ],
        ),
        title: Center(
          child: Text(
            'World News',
            style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => controller.goToCategoryView(),
            icon: Image.asset(Assets.imagesCategoriesmenu),
          ),
          IconButton(
            onPressed: () => controller.goToSettingsView(),
            icon: Icon(Icons.settings, color: Color(0xFFCFF4D2)),
          ),
        ],
      ),
      body: Obx(() {
        final articles = controller.newsHeadlines.value?.articles ?? [];

        if (controller.newsHeadlines.value == null || articles.isEmpty) {
          return Center(
            child: SpinKitFadingCircle(color: Colors.blue, size: 40),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.fetchNewsHeadlines();
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.02),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.5,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        DateTime dateTime = DateTime.parse(article.publishedAt.toString());

                        return Container(
                          width: width * 0.8,
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Stack(
                            children: [
                              if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: article.urlToImage!,
                                    height: height * 0.4,
                                    width: width * 0.8,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
                                  ),
                                )
                              else
                                Container(
                                  height: height * 0.4,
                                  width: width * 0.8,
                                  color: Colors.grey[300],
                                  child: Center(
                                    child: Text('No Image Available', style: TextStyle(color: Colors.grey[700])),
                                  ),
                                ),
                              Positioned(
                                top: height * 0.35,
                                left: 0,
                                right: 0,
                                child: Card(
                                  color: Colors.black.withOpacity(0.6),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          article.title ?? 'No title available',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          format.format(dateTime),
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    'Courtesy: ${controller.selectedFilter.value.toUpperCase()}',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.5,
                    child: ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        DateTime dateTime = DateTime.parse(article.publishedAt.toString());

                        return MouseRegion(
                          onEnter: (_) => controller.hoveredIndex.value = index,
                          onExit: (_) => controller.hoveredIndex.value = -1,
                          child: GestureDetector(
                            onTap: () => controller.goToDescriptionView(index),
                            child: Obx(() {
                              return Card(
                                color: controller.hoveredIndex.value == index
                                    ? Colors.grey[200]
                                    : Color(0xFFCFF4D2),
                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: article.urlToImage!,
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => CircularProgressIndicator(),
                                            errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
                                          ),
                                        )
                                      else
                                        Container(
                                          height: 80,
                                          width: 80,
                                          color: Colors.grey[300],
                                          child: Center(
                                            child: Text('No Image', style: TextStyle(color: Colors.grey[700])),
                                          ),
                                        ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              article.title ?? 'No title available',
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              format.format(dateTime),
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.black54,
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
