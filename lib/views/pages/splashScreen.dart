import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/splashController.dart';
import 'package:my_family_mobile_app/utils/appImages.dart';

class SplashScreen extends StatelessWidget {
  final splashController = Get.put(SplashController());

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppImages.bgSplash,
            fit: BoxFit.cover,
          ),
          Center(
            child: Image.asset(
              AppImages.logoLight,
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _logoImage() {
  return Container(
      child: Image.asset(
        AppImages.logoLight,
        height: 200,
      ),
      alignment: FractionalOffset.center);
}

Widget _backImage(double top, left) {
  return Container(
    transform: Matrix4.translationValues(left, top, 0.0),
  );
}
