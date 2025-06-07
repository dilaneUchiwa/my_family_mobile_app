import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/homeController.dart';

class NoInternet extends StatelessWidget {
  final homeController = Get.find<Homecontroller>();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.cloud_off, size: 60.0, color: Theme.of(context).hintColor),
              const SizedBox(height: 16),
              Text(
                'no_internet.title'.tr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'no_internet.desc'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => homeController.onRefresh(),
                icon: Icon(Icons.refresh),
                label: Text('no_internet.button.check'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
