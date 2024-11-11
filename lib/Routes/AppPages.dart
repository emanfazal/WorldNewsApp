import 'package:get/get.dart';
import 'package:news_app/ui/Description/DescriptionBinding.dart';
import 'package:news_app/ui/Description/DescriptionView.dart';
import 'package:news_app/ui/HomeScreen/HomeBinding.dart';
import 'package:news_app/ui/HomeScreen/HomeView.dart';
import 'package:news_app/ui/Login/LoginBinding.dart';
import 'package:news_app/ui/Login/LoginView.dart';
import 'package:news_app/ui/OnboardingScreen/OnboardingBinding.dart';
import 'package:news_app/ui/SettingsScreen/SettingBinding.dart';
import 'package:news_app/ui/SettingsScreen/SettingView.dart';
import 'package:news_app/ui/Signup/SignupBinding.dart';
import 'package:news_app/ui/Signup/SignupView.dart';

import '../ui/Category/CategoryBinding.dart';
import '../ui/Category/CategoryLogic.dart';
import '../ui/Category/CategoryView.dart';
import '../ui/OnboardingScreen/OnboardingView.dart';
import '../ui/SplashScreen/SplashBinding.dart';
import '../ui/SplashScreen/SplashView.dart';
import 'AppRoutes.dart';

class AppPages {
  static var list = [
  GetPage(
  name: AppRoutes.splash,
  page: () => Splashview(),
  binding: SplashScreenBinding(),
  ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: HomeScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.category,
      page: () => CategoryView(),
      binding: CategoryBinding(),
    )
    ,
    GetPage(
      name: AppRoutes.description,
      page: () => DescriptionView(),
      binding: DescriptionBinding(),
    )
    ,
    GetPage(
      name: AppRoutes.Onboarding,
      page: () => OnBoardingView(),
      binding: OnBoardingBinding(),
    )
    ,
    GetPage(
      name: AppRoutes.Signup,
      page: () => Signupview(),
      binding: Signupbinding(),
    )
    ,
    GetPage(
      name: AppRoutes.Settings,
      page: () => Settingview(),
      binding: SettingBinding(),
    )
    ,
    GetPage(
      name: AppRoutes.Login,
      page: () => Loginview(),
      binding: LoginBinding(),
    )

  ];}

