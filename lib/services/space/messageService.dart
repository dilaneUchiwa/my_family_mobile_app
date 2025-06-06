import 'package:dio/dio.dart';
import 'package:my_family_mobile_app/controllers/errorController.dart';
import 'package:my_family_mobile_app/domain/models/space/message.dart';
import 'package:my_family_mobile_app/helpers/urls.dart';
import 'package:my_family_mobile_app/services/utils/dioPrivate.dart';

class MessageService {
  static Future<Message?> sendMessage(Map<String, dynamic> messageData) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.post(
        URL.spaceMessageUrl,
        data: messageData,
      );
      
      if (response.statusCode == 200) {
        return Message.fromJson(response.data);
      }
      return null;
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<Message?> updateMessageContent(int messageId, String content) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.put(
        '${URL.spaceMessageUrl}/$messageId/content',
        data: content,
      );
      
      if (response.statusCode == 200) {
        return Message.fromJson(response.data);
      }
      return null;
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<bool> deleteMessage(int messageId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.delete('${URL.spaceMessageUrl}/$messageId');
      return response.statusCode == 200;
    } catch (error) {
      ErrorController.handleError(error);
      return false;
    }
  }

  static Future<Message?> getMessage(int messageId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.get('${URL.spaceMessageUrl}/$messageId');
      
      if (response.statusCode == 200) {
        return Message.fromJson(response.data);
      }
      return null;
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<List<Message>> getMessageReplies(int messageId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.get('${URL.spaceMessageUrl}/$messageId/replies');
      
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((message) => Message.fromJson(message))
            .toList();
      }
      return [];
    } catch (error) {
      ErrorController.handleError(error);
      return [];
    }
  }

  static Future<bool> markMessageAsRead(int messageId, int readerId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.post(
        '${URL.spaceMessageUrl}/$messageId/read',
        queryParameters: {'readerId': readerId},
      );
      return response.statusCode == 200;
    } catch (error) {
      ErrorController.handleError(error);
      return false;
    }
  }

  static Future<bool> markMessageAsUnread(int messageId, int readerId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.post(
        '${URL.spaceMessageUrl}/$messageId/unread',
        queryParameters: {'readerId': readerId},
      );
      return response.statusCode == 200;
    } catch (error) {
      ErrorController.handleError(error);
      return false;
    }
  }

  static Future<bool> markAllMessagesAsRead(int discussionId, int readerId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.post(
        '${URL.spaceMessageUrl}/discussion/$discussionId/read-all',
        queryParameters: {'readerId': readerId},
      );
      return response.statusCode == 200;
    } catch (error) {
      ErrorController.handleError(error);
      return false;
    }
  }

  static Future<int> getUnreadCount(int discussionId, int readerId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.get(
        '${URL.spaceMessageUrl}/discussion/$discussionId/unread-count',
        queryParameters: {'readerId': readerId},
      );
      
      if (response.statusCode == 200) {
        return response.data as int;
      }
      return 0;
    } catch (error) {
      ErrorController.handleError(error);
      return 0;
    }
  }
}
