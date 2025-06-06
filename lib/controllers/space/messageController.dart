import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/space/discussionController.dart';
import 'package:my_family_mobile_app/domain/models/space/message.dart';
import 'package:my_family_mobile_app/services/space/messageService.dart';

class MessageController extends GetxController {
  var messages = <Message>[].obs;
  var currentMessage = Rxn<Message>();
  var isLoading = false.obs;
  var unreadCount = 0.obs;

  Future<Message?> sendMessage(Map<String, dynamic> messageData) async {
    isLoading.value = true;
    try {
      final message = await MessageService.sendMessage(messageData);
      if (message != null) {
        messages.add(message);
      }
      return message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getDiscussionMessages(int discussionId) async {
    isLoading.value = true;
    try {
      final messageList = await MessageService.getMessage(discussionId);
      if (messageList != null) {
        messages.add(messageList);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUnreadCount(int discussionId, int readerId) async {
    final count = await MessageService.getUnreadCount(discussionId, readerId);
    unreadCount.value = count;
  }

  Future<bool> markAsRead(int messageId, int readerId) async {
    final success = await MessageService.markMessageAsRead(messageId, readerId);
    if (success) {
      await refreshMessage(messageId);
    }
    return success;
  }

  Future<void> refreshMessage(int messageId) async {
    final message = await MessageService.getMessage(messageId);
    if (message != null) {
      final index = messages.indexWhere((m) => m.id == messageId);
      if (index != -1) {
        messages[index] = message;
      }
    }
  }

  Future<void> onRefresh() async {
    final discussionId = Get.find<DiscussionController>().currentDiscussion.value?.id;
    if (discussionId != null) {
      await getDiscussionMessages(discussionId);
    }
  }
}
