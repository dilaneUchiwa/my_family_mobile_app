import 'package:dio/dio.dart';
import 'package:my_family_mobile_app/controllers/errorController.dart';
import 'package:my_family_mobile_app/domain/models/space/space_member.dart';
import 'package:my_family_mobile_app/helpers/urls.dart';
import 'package:my_family_mobile_app/services/utils/dioPrivate.dart';

class SpaceMemberService {
  static Future<SpaceMember?> addMember(int spaceId, int nodeId, {bool isAdmin = false}) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.post(
        '${URL.spaceMemberUrl}/$spaceId/members/$nodeId',
        queryParameters: {'isAdmin': isAdmin},
      );
      
      if (response.statusCode == 200) {
        return SpaceMember.fromJson(response.data);
      }
      return null;
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<bool> removeMember(int spaceId, int nodeId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.delete(
        '${URL.spaceMemberUrl}/$spaceId/members/$nodeId',
      );
      return response.statusCode == 200;
    } catch (error) {
      ErrorController.handleError(error);
      return false;
    }
  }

  static Future<bool> setMemberAdmin(int spaceId, int nodeId, bool isAdmin) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.put(
        '${URL.spaceMemberUrl}/$spaceId/members/$nodeId/admin',
        queryParameters: {'isAdmin': isAdmin},
      );
      return response.statusCode == 200;
    } catch (error) {
      ErrorController.handleError(error);
      return false;
    }
  }

  static Future<List<SpaceMember>> getSpaceMembers(int spaceId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.get('${URL.spaceMemberUrl}/$spaceId/members');
      
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((member) => SpaceMember.fromJson(member))
            .toList();
      }
      return [];
    } catch (error) {
      ErrorController.handleError(error);
      return [];
    }
  }

  static Future<List<SpaceMember>> getSpaceAdmins(int spaceId) async {
    try {
      final dio = await getDioPrivate();
      final response = await dio.get('${URL.spaceMemberUrl}/$spaceId/members/admins');
      
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((member) => SpaceMember.fromJson(member))
            .toList();
      }
      return [];
    } catch (error) {
      ErrorController.handleError(error);
      return [];
    }
  }
}
