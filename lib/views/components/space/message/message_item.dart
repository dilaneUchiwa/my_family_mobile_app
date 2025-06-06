import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/homeController.dart';
import 'package:my_family_mobile_app/domain/models/space/message.dart';
import 'package:my_family_mobile_app/themes/theme.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessageItem extends StatelessWidget {
  final Message message;
  final VoidCallback onReply;
  final homeController = Get.find<Homecontroller>();

  MessageItem({
    required this.message,
    required this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    final isMyMessage = message.senderId == homeController.account.value.baseNode.id;

    return Align(
      alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMyMessage ? AppColors.primary : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMyMessage)
              Text(
                message.senderName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isMyMessage ? Colors.white : Colors.black,
                ),
              ),
            Text(
              message.content,
              style: TextStyle(
                color: isMyMessage ? Colors.white : Colors.black,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  timeago.format(message.sendDate),
                  style: TextStyle(
                    fontSize: 12,
                    color: isMyMessage ? Colors.white70 : Colors.grey,
                  ),
                ),
                if (message.read)
                  Icon(
                    Icons.done_all,
                    size: 14,
                    color: isMyMessage ? Colors.white70 : Colors.blue,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
