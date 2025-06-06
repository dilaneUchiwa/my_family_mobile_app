import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:my_family_mobile_app/themes/theme.dart';

enum ToastType { success, error, info, warning }

class ToastController extends GetxController {
  String? title;
  String? message;
  ToastType type;

  ToastController({
    this.title, 
    this.message, 
    this.type = ToastType.success
  });

  Color _getToastColor() {
    switch (type) {
      case ToastType.success:
        return Colors.green;
      case ToastType.error:
        return Colors.red;
      case ToastType.info:
        return AppColors.primary;
      case ToastType.warning:
        return Colors.orange;
      default:
        return AppColors.primary;
    }
  }

  void showToast() {
    showToastWidget(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey[800] : _getToastColor(),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Text(
          message ?? '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      duration: const Duration(seconds: 3),
      position: ToastPosition.top,
      dismissOtherToast: true,
    );
  }
}
