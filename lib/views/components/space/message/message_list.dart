import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/space/messageController.dart';
import 'package:my_family_mobile_app/views/components/space/message/message_item.dart';

class MessageList extends StatelessWidget {
  final messageController = Get.find<MessageController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => messageController.isLoading.value
        ? Center(child: CircularProgressIndicator())
        : messageController.messages.isEmpty
            ? ListView(
                children: [
                  SizedBox(height: Get.height * 0.3),
                  Center(
                    child: Column(
                      children: [
                        Icon(Icons.chat_bubble_outline, size: 50, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('no_messages'.tr, style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              )
            : ListView.builder(
                reverse: true,
                itemCount: messageController.messages.length,
                itemBuilder: (context, index) {
                  final message = messageController.messages[index];
                  return MessageItem(
                    message: message,
                    onReply: () {
                      messageController.currentMessage.value = message;
                      // Show reply input
                    },
                  );
                },
              ));
  }
}
