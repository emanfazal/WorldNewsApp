import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../generated/assets.dart';
import 'OnboardingLogic.dart';

class OnBoardingView extends StatelessWidget {
  OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OnBoardingLogic>(
        builder: (logic) {
          return Stack(
            children: [
              PageView.builder(
                onPageChanged: logic.onPageChanged,
                controller: logic.pageController,
                itemCount: pagesImages.length,
                itemBuilder: (_, index) {
                  return Container(
                    width: double.infinity, // Ensure the width takes full screen width
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(pagesImages[index].image),
                        fit: BoxFit.cover, // Adjusts the image to cover the whole container
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20), // Space above the image
                          Text(
                            pagesImages[index].text,
                            style: TextStyle(
                              color: Colors.white, // Set text color for better visibility
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              Padding(
                padding: const EdgeInsets.only(top:300),
                child: Center(
                  child: SmoothPageIndicator(
                    controller: logic.pageController,
                    count: pagesImages.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 15,
                      dotWidth: 15,
                      activeDotColor: Colors.white, // Active dot color
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 120, // Adjust bottom position to fit the button
                left: 0,
                right: 0,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      logic.onTapNext();
                      if(logic.currantPageIndex==2){
                        logic.goToSignupView();
                      }
                    },
                    child: Text(
                      logic.getButtonText(), // Use the method from OnBoardingLogic
                      style: GoogleFonts.poppins(color: Colors.white54),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      backgroundColor: Colors.blue, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
              bottom: 40,
                left: 0,
                right: 0,
                child: logic.currantPageIndex < 2
                    ? InkWell(
                  onTap: () {
                    print('Skip button pressed');
                    logic.goToSignupView();
                    // Handle skip action, navigate to main screen or another page
                  },
                  child: Center(
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white, // Set color for visibility
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
                    : SizedBox.shrink(), // Hide the button on the last page
              ),


            ],
          );
        },
      ),
    );
  }

  final pagesImages = List.generate(3, (index) {
    List<String> listImagesUser = [
      Assets.imagesOnboardingPage1,
      Assets.imagesOnboardingPage2,
      Assets.imagesOnboardingPage3,
    ];

    List<String> listIntroTextUser = [
      'News according to your Preference and Interest'.tr,
      'Read anytime anywhere even without internet'.tr,
      'Share with your friends and community'.tr,
    ];

    return PageContent(
      image: listImagesUser[index],
      text: listIntroTextUser[index],
    );
  });
}

// Create a class to hold the image and text together
class PageContent {
  final String image;
  final String text;

  PageContent({required this.image, required this.text});
}
