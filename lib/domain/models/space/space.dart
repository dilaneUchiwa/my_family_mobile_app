class Space {
  int id;
  int creatorId;
  List<int> spaceMemberIds;

  Space({
    required this.id,
    required this.creatorId,
    required this.spaceMemberIds,
  });

  factory Space.fromJson(Map<String, dynamic> json) {
    return Space(
      id: json['id'],
      creatorId: json['creatorId'],
      spaceMemberIds: List<int>.from(json['spaceMemberIds']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'creatorId': creatorId,
    'spaceMemberIds': spaceMemberIds,
  };
}
