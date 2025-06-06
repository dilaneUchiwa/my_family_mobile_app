import 'package:get/get.dart';
import 'package:my_family_mobile_app/routes/appRoutes.dart';
import 'package:my_family_mobile_app/views/pages/homePage.dart';
import 'package:my_family_mobile_app/views/pages/splashScreen.dart';

class AppRouter {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      // binding: HomeBinding(),
    ),
    GetPage(name: AppRoutes.splash, page: () => SplashScreen())
  ];
}
