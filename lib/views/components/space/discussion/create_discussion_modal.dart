import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/space/discussionController.dart';
import 'package:my_family_mobile_app/controllers/space/spaceController.dart';
import 'package:my_family_mobile_app/routes/appRoutes.dart';

class CreateDiscussionModal extends StatelessWidget {
  final discussionController = Get.find<DiscussionController>();
  final spaceController = Get.find<SpaceController>();
  final selectedMembers = <int>[].obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'create_discussion'.tr,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _createP2PDiscussion(),
                child: Text('p2p_discussion'.tr),
              ),
              ElevatedButton(
                onPressed: () => _createGroupDiscussion(),
                child: Text('group_discussion'.tr),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _createP2PDiscussion() {
    Get.back();
    Get.toNamed(AppRoutes.discussionSelectMembers, arguments: {'type': 'P2P'});
  }

  void _createGroupDiscussion() {
    Get.back();
    Get.toNamed(AppRoutes.discussionSelectMembers, arguments: {'type': 'GROUP'});
  }
}
