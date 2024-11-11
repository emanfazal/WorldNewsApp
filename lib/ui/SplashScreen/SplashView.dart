import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Utils/Assets/Assets.dart';
import 'SplashLogic.dart';

class Splashview extends StatelessWidget {
  Splashview({super.key});

  final controller = Get.find<SplashScreenLogic>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*1;
    final width = MediaQuery.of(context).size.width*1;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF215273),
              Color(0xFF359D9E),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Image.asset(Assets.assetsSplashscreen),
              ),

              SizedBox(height: height*0.04,),
              Text(
                'Top Headlines',
                style: GoogleFonts.anton(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: height*0.04,),
              SpinKitChasingDots(
                color: Colors.blue,
              )
            ],
          )
        ),
      ),
    );
  }
}
