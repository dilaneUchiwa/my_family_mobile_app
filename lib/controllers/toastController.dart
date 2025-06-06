import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class ToastController extends GetxController {
  String? title;
  String? message;

  ToastController({this.title, this.message});

  void showToast() {
    showToastWidget(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
            // width: Get.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Get.isDarkMode ? Colors.grey[200] : Colors.grey[900],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    message ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: Get.isDarkMode ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        dismissOtherToast: true);
  }
}
