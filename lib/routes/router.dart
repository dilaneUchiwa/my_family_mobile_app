import 'package:get/get.dart';
import 'package:my_family_mobile_app/routes/appRoutes.dart';
import 'package:my_family_mobile_app/views/pages/MainPage.dart';
import 'package:my_family_mobile_app/views/pages/homePage.dart';
import 'package:my_family_mobile_app/views/pages/linkToFamilyPage.dart';
import 'package:my_family_mobile_app/views/pages/loginPage.dart';
import 'package:my_family_mobile_app/views/pages/registerPage.dart';
import 'package:my_family_mobile_app/views/pages/splashScreen.dart';

class AppRouter {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => Mainpage(),
      // binding: HomeBinding(),
    ),
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage()
    ),
    GetPage(name: AppRoutes.register, page: ()=> RegisterPage() ),
    GetPage(name: AppRoutes.link_to_invite, page: () => LinkToFamilyPage() ),
  ];
}
