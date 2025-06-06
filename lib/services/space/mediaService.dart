import 'package:dio/dio.dart';
import 'package:my_family_mobile_app/controllers/errorController.dart';
import 'package:my_family_mobile_app/domain/models/space/media.dart';
import 'package:my_family_mobile_app/helpers/urls.dart';
import 'package:my_family_mobile_app/services/utils/dioPrivate.dart';

class MediaService {
  static Future<Media?> createMedia(int messageId, String path, String type) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.post(
        URL.spaceMediaUrl,
        queryParameters: {
          'messageId': messageId,
          'path': path,
          'type': type,
        },
      );
      
      if (response.statusCode == 200) {
        return Media.fromJson(response.data);
      }
      return null;
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<Media?> updateMediaType(int id, String type) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.put(
        '${URL.spaceMediaUrl}/$id/type',
        data: type,
      );
      
      if (response.statusCode == 200) {
        return Media.fromJson(response.data);
      }
      return null;
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<Media?> updateMediaPath(int id, String path) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.put(
        '${URL.spaceMediaUrl}/$id/path',
        data: path,
      );
      
      if (response.statusCode == 200) {
        return Media.fromJson(response.data);
      }
      return null;
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<Media?> getMedia(int id) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.get('${URL.spaceMediaUrl}/$id');
      
      if (response.statusCode == 200) {
        return Media.fromJson(response.data);
      }
      return null;
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<bool> deleteMedia(int id) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.delete('${URL.spaceMediaUrl}/$id');
      return response.statusCode == 200;
    } catch (error) {
      ErrorController.handleError(error);
      return false;
    }
  }

  static Future<List<Media>> getMediasByType(String type) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.get('${URL.spaceMediaUrl}/type/$type');
      
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((media) => Media.fromJson(media))
            .toList();
      }
      return [];
    } catch (error) {
      ErrorController.handleError(error);
      return [];
    }
  }

  static Future<List<Media>> getMessageMedias(int messageId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.get('${URL.spaceMediaUrl}/message/$messageId');
      
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((media) => Media.fromJson(media))
            .toList();
      }
      return [];
    } catch (error) {
      ErrorController.handleError(error);
      return [];
    }
  }

  static Future<bool> deleteMessageMedias(int messageId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.delete('${URL.spaceMediaUrl}/message/$messageId');
      return response.statusCode == 200;
    } catch (error) {
      ErrorController.handleError(error);
      return false;
    }
  }
}
