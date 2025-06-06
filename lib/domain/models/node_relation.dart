import 'package:my_family_mobile_app/domain/models/node.dart';

class NodeRelation {
  BaseNode node1;
  BaseNode node2;
  String relationType;

  NodeRelation({
    required this.node1,
    required this.node2,
    required this.relationType,
  });

  factory NodeRelation.fromJson(Map<String, dynamic> json) {
    return NodeRelation(
      node1: BaseNode.fromJson(json['node1']),
      node2: BaseNode.fromJson(json['node2']),
      relationType: json['relationType'],
    );
  }
}
