import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/homeController.dart';
import 'package:my_family_mobile_app/controllers/space/discussionController.dart';
import 'package:my_family_mobile_app/controllers/space/eventController.dart';
import 'package:my_family_mobile_app/controllers/space/mediaController.dart';
import 'package:my_family_mobile_app/controllers/space/messageController.dart';
import 'package:my_family_mobile_app/controllers/space/spaceController.dart';
import 'package:my_family_mobile_app/controllers/toastController.dart';
import 'package:my_family_mobile_app/views/components/bottom_navigation_bar.dart';
import 'package:my_family_mobile_app/views/components/custom_drawer.dart';
import 'package:my_family_mobile_app/views/components/no_internet.dart';
import 'package:my_family_mobile_app/views/pages/homePage.dart';

class Mainpage extends StatelessWidget {
   Mainpage({super.key});

  final homeController = Get.find<Homecontroller>();

  Widget _buildPageContent() => Obx(
        () => Center(
          child: callPage(homeController.selectedNavIndex.value),
        ),
      );

  Widget callPage(int current) {
    switch (current) {
      case 0:
        return const HomePage();
      case 1:
        return const HomePage();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put<EventController>(EventController(),permanent: true);
    Get.put<SpaceController>(SpaceController(),permanent: true);
    Get.put<DiscussionController>(DiscussionController(),permanent: true);
    Get.put<MediaController>(MediaController(),permanent: true);
    Get.put<MessageController>(MessageController(),permanent: true);
    
    
    return Obx(() => homeController.isOnline.value
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: PopScope(
              canPop: false,
              onPopInvoked: (didPop) async {
                if (didPop) return;
                await _handleBackPress(context);
              },
              child: _buildPageContent(),
            ),
            bottomNavigationBar: BottomNavigationBarComponent(),
          )
        : NoInternet());
  }

  Future<void> _handleBackPress(BuildContext context) async {
    final now = DateTime.now();
    final lastPress = homeController.currentBackPressTime.value;

    if (lastPress == null || now.difference(lastPress) > const Duration(seconds: 2)) {
      homeController.currentBackPressTime.value = now;
      _showBackWarning();
      return;
    }
    Navigator.of(context).pop();
  }

  void _showBackWarning() {
    ToastController(
      title: '',
      message: 'input.home.back.text'.tr,
    ).showToast();
  }
}
