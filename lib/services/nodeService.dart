import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:my_family_mobile_app/controllers/errorController.dart';
import 'package:my_family_mobile_app/domain/models/node.dart';
import 'package:my_family_mobile_app/domain/models/node_relation.dart';
import 'package:my_family_mobile_app/helpers/urls.dart';
import 'package:my_family_mobile_app/services/utils/dioPrivate.dart';

class NodeService {
  static Future<List<NodeRelation>> getFamilyRelations() async {
    try {
      final Dio dio = await getDioPrivate();
      final response = await dio.get(URL.getNodeUrl);

      if (response.statusCode == 200) {
        List<dynamic> relations = response.data;
        return relations.map((relation) => NodeRelation.fromJson(relation)).toList();
      } else {
        ErrorController.handleError(response);
        return [];
      }
    } catch (error) {
      ErrorController.handleError(error);
      return [];
    }
  }

  static Future<BaseNode?> getNodeById(int id) async {
    try {
      final Dio dio = await getDioPrivate();
      final response = await dio.get('${URL.getNodeByIdUrl}$id');

      if (response.statusCode == 200) {
        return BaseNode.fromJson(response.data);
      } else {
        ErrorController.handleError(response);
        return null;
      }
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<BaseNode?> createNode(Map<String, dynamic> nodeData) async {
    try {

      final Dio dio = await getDioPrivate();
      final response = await dio.post(
        URL.createNodeUrl,
        data: jsonEncode(nodeData),
      );

      if (response.statusCode == 201) {
        return BaseNode.fromJson(response.data);
      } else {
        ErrorController.handleError(response);
        return null;
      }
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<BaseNode?> updateNode(int id, Map<String, dynamic> nodeData) async {
    try {
      final Dio dio = await getDioPrivate();
      final response = await dio.put(
        '${URL.updateNodeUrl}$id',
        data: jsonEncode(nodeData),
      );

      if (response.statusCode == 200) {
        return BaseNode.fromJson(response.data);
      } else {
        ErrorController.handleError(response);
        return null;
      }
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<Map<String, dynamic>?> createInvitation(int nodeId) async {
    try {
      final Dio dio = await getDioPrivate();
      final response = await dio.post(
        URL.createInvitationUrl,
        data: jsonEncode({'nodeId': nodeId}),
      );

      if (response.statusCode == 201) {
        return response.data;
      } else {
        ErrorController.handleError(response);
        return null;
      }
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }

  static Future<Map<String, dynamic>?> useInvitation(String invitationKey) async {
    try {
      final Dio dio = await getDioPrivate();
      final response = await dio.put('${URL.useInvitationUrl}$invitationKey/use');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        ErrorController.handleError(response);
        return null;
      }
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }
}
