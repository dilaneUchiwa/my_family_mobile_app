class SpaceMember {
  int id;
  int spaceId;
  int nodeId;
  bool admin;

  SpaceMember({
    required this.id,
    required this.spaceId,
    required this.nodeId,
    required this.admin,
  });

  factory SpaceMember.fromJson(Map<String, dynamic> json) => SpaceMember(
    id: json['id'],
    spaceId: json['spaceId'],
    nodeId: json['nodeId'],
    admin: json['admin'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'spaceId': spaceId,
    'nodeId': nodeId,
    'admin': admin,
  };
}
