import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Routes/AppPages.dart';
import 'Routes/AppRoutes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.light,
        ));

        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        return FutureBuilder<String>(
          future: _determineInitialRoute(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading screen while checking authentication status
              return const MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return const MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Center(child: Text('Error occurred')),
              );
            } else {
              // Get the initial route based on login status
              String initialRoute = snapshot.data ?? AppRoutes.splash;

              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                getPages: AppPages.list,
                defaultTransition: Transition.fade,
                transitionDuration: const Duration(milliseconds: 200),
                initialRoute: initialRoute,
              );
            }
          },
        );
      },
    );
  }

  // Check if the user is logged in or not
  Future<String> _determineInitialRoute() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null ? AppRoutes.home: AppRoutes.splash;
  }
}
