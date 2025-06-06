import 'package:dio/dio.dart';
import 'package:my_family_mobile_app/controllers/errorController.dart';
import 'package:my_family_mobile_app/domain/models/space/discussion.dart';
import 'package:my_family_mobile_app/helpers/urls.dart';
import 'package:my_family_mobile_app/services/utils/dioPrivate.dart';

class DiscussionService {
  static Future<Discussion?> createP2PDiscussion(int spaceId, List<int> participantIds) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.post(
        '${URL.spaceDiscussionUrl}/p2p',
        queryParameters: {'spaceId': spaceId},
        data: participantIds,
      );
      
      if (response.statusCode == 200) {
        return Discussion.fromJson(response.data);
      }
      return null;
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<Discussion?> createGroupDiscussion(int spaceId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.post(
        '${URL.spaceDiscussionUrl}/group',
        queryParameters: {'spaceId': spaceId},
      );
      
      if (response.statusCode == 200) {
        return Discussion.fromJson(response.data);
      }
      return null;
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<Discussion?> createEventDiscussion(int spaceId, int eventId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.post(
        '${URL.spaceDiscussionUrl}/event',
        queryParameters: {
          'spaceId': spaceId,
          'eventId': eventId,
        },
      );
      
      if (response.statusCode == 200) {
        return Discussion.fromJson(response.data);
      }
      return null;
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<Discussion?> getDiscussion(int id) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.get('${URL.spaceDiscussionUrl}/$id');
      
      if (response.statusCode == 200) {
        return Discussion.fromJson(response.data);
      }
      return null;
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<bool> deleteDiscussion(int id) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.delete('${URL.spaceDiscussionUrl}/$id');
      return response.statusCode == 200;
    } catch (error) {
      ErrorController.handleError(error);
      return false;
    }
  }

  static Future<List<int>> getDiscussionParticipants(int discussionId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.get('${URL.spaceDiscussionUrl}/$discussionId/participants');
      
      if (response.statusCode == 200) {
        return List<int>.from(response.data);
      }
      return [];
    } catch (error) {
      ErrorController.handleError(error);
      return [];
    }
  }

  static Future<List<Discussion>> getSpaceDiscussions(int spaceId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.get('${URL.spaceDiscussionUrl}/space/$spaceId');
      
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((discussion) => Discussion.fromJson(discussion))
            .toList();
      }
      return [];
    } catch (error) {
      ErrorController.handleError(error);
      return [];
    }
  }

  static Future<bool> addParticipant(int discussionId, int nodeId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.post(
        '${URL.spaceDiscussionUrl}/$discussionId/participants/$nodeId'
      );
      return response.statusCode == 200;
    } catch (error) {
      ErrorController.handleError(error);
      return false;
    }
  }

  static Future<bool> removeParticipant(int discussionId, int nodeId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.delete(
        '${URL.spaceDiscussionUrl}/$discussionId/participants/$nodeId'
      );
      return response.statusCode == 200;
    } catch (error) {
      ErrorController.handleError(error);
      return false;
    }
  }
}
