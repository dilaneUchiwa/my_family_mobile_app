import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/homeController.dart';
import 'package:my_family_mobile_app/controllers/space/discussionController.dart';
import 'package:my_family_mobile_app/controllers/space/messageController.dart';
import 'package:my_family_mobile_app/views/components/space/message/message_list.dart';
import 'package:my_family_mobile_app/controllers/toastController.dart';

class MessagePage extends StatelessWidget {
  final messageController = Get.put(MessageController());
  final discussionController = Get.find<DiscussionController>();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(discussionController.currentDiscussion.value?.type ?? ''),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => messageController.onRefresh(),
              child: MessageList(),
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'type_message'.tr,
                border: InputBorder.none,
              ),
              minLines: 1,
              maxLines: 5,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (textController.text.trim().isEmpty) {
      ToastController(
        title: 'Error'.tr,
        message: 'Message cannot be empty'.tr,
        type: ToastType.error
      ).showToast();
      return;
    }
    final messageData = {
      'content': textController.text,
      'discussionId': discussionController.currentDiscussion.value?.id,
      'senderId': Get.find<Homecontroller>().account.value.baseNode.id,
    };
    messageController.sendMessage(messageData).then((message) {
      if (message != null) {
        ToastController(
          title: 'Success'.tr,
          message: 'message_sent'.tr,
          type: ToastType.success
        ).showToast();
      }
    });
    textController.clear();
  }
}
