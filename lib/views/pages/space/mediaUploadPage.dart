import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/space/mediaController.dart';
import 'package:my_family_mobile_app/controllers/toastController.dart';

class MediaUploadPage extends StatelessWidget {
  final mediaController = Get.find<MediaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('upload_media'.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ToastController(
                  title: 'Info'.tr,
                  message: 'Media upload not implemented yet'.tr,
                  type: ToastType.info
                ).showToast();
              },
              child: Text('select_files'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
