import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_family_mobile_app/routes/appRoutes.dart';
import 'package:my_family_mobile_app/routes/router.dart';
import 'package:my_family_mobile_app/themes/theme.dart';
import 'package:my_family_mobile_app/utils/message.dart';
import 'package:my_family_mobile_app/utils/storageConstant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final langCode = GetStorage().read(StorageConstants.langCode);
  final langCountryCode = GetStorage().read(StorageConstants.langCountryCode);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Family Tree',
      translations: Messages(),
      initialRoute: AppRoutes.splash,
      getPages: AppRouter.routes,
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      locale: langCode == null && langCountryCode == null
              ? const Locale('en', 'US')
              : Locale(langCode, langCountryCode),
    );
  }
}