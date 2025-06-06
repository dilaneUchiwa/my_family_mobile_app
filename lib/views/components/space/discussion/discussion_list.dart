import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/space/discussionController.dart';
import 'package:my_family_mobile_app/routes/appRoutes.dart';
import 'package:my_family_mobile_app/views/components/space/discussion/discussion_item.dart';

class DiscussionList extends StatelessWidget {
  final discussionController = Get.find<DiscussionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => discussionController.isLoading.value
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: discussionController.discussions.length,
            itemBuilder: (context, index) {
              final discussion = discussionController.discussions[index];
              return DiscussionItem(
                discussion: discussion,
                onTap: () {
                  discussionController.currentDiscussion.value = discussion;
                  Get.toNamed(AppRoutes.discussionMessages);
                },
              );
            },
          ));
  }
}
