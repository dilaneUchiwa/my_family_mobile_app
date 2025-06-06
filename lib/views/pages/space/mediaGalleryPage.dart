import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/space/mediaController.dart';
import 'package:my_family_mobile_app/routes/appRoutes.dart';

class MediaGalleryPage extends StatelessWidget {
  final mediaController = Get.find<MediaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('space_media'.tr),
        actions: [
          IconButton(
            icon: Icon(Icons.upload),
            onPressed: () => Get.toNamed(AppRoutes.spaceMediaUpload),
          ),
        ],
      ),
      body: Obx(() => mediaController.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => mediaController.onRefresh(),
              child: mediaController.medias.isEmpty
                  ? ListView(
                      children: [
                        SizedBox(height: Get.height * 0.3),
                        Center(
                          child: Column(
                            children: [
                              Icon(Icons.photo_library_outlined, size: 50, color: Colors.grey),
                              SizedBox(height: 16),
                              Text('no_media'.tr, style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ],
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                      ),
                      itemCount: mediaController.medias.length,
                      itemBuilder: (context, index) {
                        final media = mediaController.medias[index];
                        return Image.network(
                          media.path,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
            )),
    );
  }
}
