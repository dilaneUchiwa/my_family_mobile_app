import 'package:dio/dio.dart';
import 'package:my_family_mobile_app/controllers/errorController.dart';
import 'package:my_family_mobile_app/domain/models/space/event.dart';
import 'package:my_family_mobile_app/helpers/urls.dart';
import 'package:my_family_mobile_app/services/utils/dioPrivate.dart';

class EventService {
  static Future<Event?> createEvent(Event event) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.post(
        URL.spaceEventUrl,
        data: event.toJson(),
      );
      
      if (response.statusCode == 200) {
        return Event.fromJson(response.data);
      }
      return null;
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<Event?> getEvent(int id) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.get('${URL.spaceEventUrl}/$id');
      
      if (response.statusCode == 200) {
        return Event.fromJson(response.data);
      }
      return null;
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<Event?> updateEvent(int id, Event event) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.put(
        '${URL.spaceEventUrl}/$id',
        data: event.toJson(),
      );
      
      if (response.statusCode == 200) {
        return Event.fromJson(response.data);
      }
      return null;
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<bool> deleteEvent(int id) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.delete('${URL.spaceEventUrl}/$id');
      return response.statusCode == 200;
    } catch (error) {
      ErrorController.handleError(error);
      return false;
    }
  }

  static Future<List<Event>> getSpaceEvents(int spaceId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.get('${URL.spaceEventUrl}/space/$spaceId');
      
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((event) => Event.fromJson(event))
            .toList();
      }
      return [];
    } catch (error) {
      ErrorController.handleError(error);
      return [];
    }
  }

  static Future<Event?> addParticipant(int eventId, int nodeId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.post(
        '${URL.spaceEventUrl}/$eventId/participants/$nodeId'
      );
      
      if (response.statusCode == 200) {
        return Event.fromJson(response.data);
      }
      return null;
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<Event?> removeParticipant(int eventId, int nodeId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.delete(
        '${URL.spaceEventUrl}/$eventId/participants/$nodeId'
      );
      
      if (response.statusCode == 200) {
        return Event.fromJson(response.data);
      }
      return null;
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }
}
