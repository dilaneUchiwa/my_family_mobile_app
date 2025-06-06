class Discussion {
  int id;
  String type;
  int spaceId;
  int? eventId;
  List<int> participantIds;

  Discussion({
    required this.id,
    required this.type,
    required this.spaceId,
    this.eventId,
    required this.participantIds,
  });

  factory Discussion.fromJson(Map<String, dynamic> json) => Discussion(
    id: json['id'],
    type: json['type'],
    spaceId: json['spaceId'],
    eventId: json['eventId'],
    participantIds: List<int>.from(json['participantIds']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'spaceId': spaceId,
    'eventId': eventId,
    'participantIds': participantIds,
  };
}
