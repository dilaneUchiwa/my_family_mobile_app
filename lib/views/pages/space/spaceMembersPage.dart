import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/space/spaceController.dart';

class SpaceMembersPage extends StatelessWidget {
  final spaceController = Get.find<SpaceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('space_members'.tr)),
      body: Obx(() => ListView.builder(
        itemCount: spaceController.currentSpace.value?.spaceMemberIds.length ?? 0,
        itemBuilder: (context, index) {
          // Member list items will be added here
          return ListTile();
        },
      )),
    );
  }
}
