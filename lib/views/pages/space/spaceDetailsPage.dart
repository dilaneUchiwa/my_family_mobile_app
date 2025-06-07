import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/space/spaceController.dart';
import 'package:my_family_mobile_app/themes/theme.dart';
import 'package:my_family_mobile_app/routes/appRoutes.dart';

class SpaceDetailsPage extends StatelessWidget {
  final spaceController = Get.find<SpaceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('Space ${spaceController.currentSpace.value?.id}')),
        actions: [
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () => Get.toNamed(AppRoutes.spaceMembers),
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Get.toNamed(AppRoutes.spaceSettings),
          ),
        ],
      ),
      body: Obx(() => spaceController.currentSpace.value == null
          ? Center(child: Text('space_not_found'.tr))
          : ListView(
              children: [
                SpaceInfoCard(),
                SpaceActionsList(),
              ],
            )),
    );
  }
}

class SpaceInfoCard extends StatelessWidget {
  final spaceController = Get.find<SpaceController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  radius: 30,
                  child: Icon(Icons.group, size: 30, color: Colors.white),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Space ${spaceController.currentSpace.value?.id}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        '${spaceController.currentSpace.value?.spaceMemberIds.length ?? 0} members',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SpaceActionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.chat),
          title: Text('space.discussions'.tr),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () => Get.toNamed(AppRoutes.spaceDiscussions),
        ),
        ListTile(
          leading: Icon(Icons.event),
          title: Text('space.events'.tr),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () => Get.toNamed(AppRoutes.spaceEvents),
        ),
        ListTile(
          leading: Icon(Icons.photo_library),
          title: Text('space.media'.tr),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () => Get.toNamed(AppRoutes.spaceMedia),
        ),
      ],
    );
  }
}
