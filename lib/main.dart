import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_family_mobile_app/utils/message.dart';
import 'package:oktoast/oktoast.dart';
import 'package:my_family_mobile_app/routes/router.dart';
import 'package:my_family_mobile_app/services/utils/AuthManager.dart';
import 'package:my_family_mobile_app/themes/theme.dart';

void main() async {
  await GetStorage.init();
  Get.put(AuthManager());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Family Tree',
        theme: Themes.lightTheme,
        translations: Messages(),
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        initialRoute: '/splash',
        getPages: AppRouter.routes,
      ),
    );
  }
}