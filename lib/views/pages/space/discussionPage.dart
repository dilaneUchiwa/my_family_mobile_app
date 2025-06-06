import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/space/discussionController.dart';
import 'package:my_family_mobile_app/views/components/space/discussion/discussion_list.dart';
import 'package:my_family_mobile_app/views/components/space/discussion/create_discussion_modal.dart';

class DiscussionPage extends StatelessWidget {
  final discussionController = Get.put(DiscussionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('discussions'.tr),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showCreateDiscussionModal(context),
          ),
        ],
      ),
      body: DiscussionList(),
    );
  }

  void _showCreateDiscussionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => CreateDiscussionModal(),
      isScrollControlled: true,
    );
  }
}
