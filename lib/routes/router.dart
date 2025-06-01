import 'package:get/get.dart';
import 'package:my_family_mobile_app/views/pages/HomePage.dart';

class AppRouter {
  static final routes = [
    GetPage(
      name: '/home',
      page: () => const HomePage(),
      // binding: HomeBinding(),
    ),
  ];
}