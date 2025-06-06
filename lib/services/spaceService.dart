import 'package:dio/dio.dart';
import 'package:my_family_mobile_app/controllers/errorController.dart';
import 'package:my_family_mobile_app/domain/models/space/space.dart';
import 'package:my_family_mobile_app/domain/models/space/space_node.dart';
import 'package:my_family_mobile_app/helpers/urls.dart';
import 'package:my_family_mobile_app/services/utils/dioPrivate.dart';

class SpaceService {
  static Future<List<Space>> getSpaces() async {
    try {
      final Dio dio = await getDioPrivate();
      final response = await dio.get(URL.spaceUrl);

      if (response.statusCode == 200) {
        List<dynamic> spaces = response.data;
        return spaces.map((space) => Space.fromJson(space)).toList();
      } else {
        ErrorController.handleError(response);
        return [];
      }
    } catch (error) {
      ErrorController.handleError(error);
      return [];
    }
  }

  static Future<Space?> createSpace(Space space) async {
    try {
      final Dio dio = await getDioPrivate();
      final response = await dio.post(
        URL.spaceUrl,
        data: space.toJson(),
      );

      if (response.statusCode == 200) {
        return Space.fromJson(response.data);
      } else {
        ErrorController.handleError(response);
        return null;
      }
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<SpaceNode?> createSpaceNode(SpaceNode node) async {
    try {
      final Dio dio = await getDioPrivate();
      final response = await dio.post(
        URL.spaceNodeUrl,
        data: node.toJson(),
      );

      if (response.statusCode == 200) {
        return SpaceNode.fromJson(response.data);
      } else {
        ErrorController.handleError(response);
        return null;
      }
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<bool> addMemberToSpace(int spaceId, int nodeId, {bool isAdmin = false}) async {
    try {
      final Dio dio = await getDioPrivate();
      final response = await dio.post(
        '${URL.spaceMemberUrl}/$spaceId/members/$nodeId',
        queryParameters: {'isAdmin': isAdmin},
      );

      return response.statusCode == 200;
    } catch (error) {
      ErrorController.handleError(error);
      return false;
    }
  }
}
