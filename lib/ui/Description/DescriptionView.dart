import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Models/CategoriesModel.dart';
import '../../Models/NewsChannelHeadlinesModel.dart';
import '../HomeScreen/HomeLogic.dart';

class DescriptionView extends StatelessWidget {
  final controller = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    // Get the article index from arguments, with a null check and default value
    int index = Get.arguments != null && Get.arguments is int ? Get.arguments as int : -1;

    // Ensure that we have valid articles and an index
    var article = (index >= 0 && controller.newsHeadlines.value?.articles != null)
        ? controller.newsHeadlines.value!.articles![index]
        : null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Center(
          child: Text(
            'Description',
            style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: article != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            article.urlToImage != null
                ? Image.network(
              article.urlToImage!,
              height: 200,
              fit: BoxFit.cover,
            )
                : Container(height: 200, color: Colors.grey), // Placeholder if no image

            // Display the article title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                article.title ?? 'No Title Available',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),

            // Button to show the description in a modal bottom sheet
            // Button to show the description in a modal bottom sheet
            Container(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    barrierLabel: 'Description',
                    context: context,
                    isScrollControlled: true, // Allow the bottom sheet to take the full height
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.all(16.0),
                        height: 200, // Set the desired height of the modal bottom sheet
                        decoration: BoxDecoration(
                          color: Colors.grey[200], // Background color of the modal
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Border radius
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                          Text(
                          'Description',
                          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                            SizedBox(height: 10),
                            Text(
                              article.description ?? 'No description available',
                              style:GoogleFonts.poppins(fontSize: 20,),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },

                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFFCFF4D2),
                  backgroundColor: Colors.grey,

                ),
                child: Text(
                  ' Read More',
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),


          ],
        ),
      )
          : Center(child: Text('Article not found')),
    );
  }
}
