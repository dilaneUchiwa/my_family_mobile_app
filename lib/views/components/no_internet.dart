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
              Icon(Icons.cloud_off,
                  size: 60.0, color: Theme.of(context).hintColor),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'no_internet.title'.tr,
                style: TextStyle(
                    fontFamily: "Arial",
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    fontSize: 20),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'no_internet.desc'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Arial",
                  fontSize: 16,
                  color: Theme.of(context).hintColor,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextButton(
                child: Text(
                  'no_internet.button.check'.tr,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
                style: TextButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                    backgroundColor: Theme.of(context).primaryColor,
                    textStyle: TextStyle(fontFamily: "Arial")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
