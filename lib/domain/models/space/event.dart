class Event {
  int id;
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  int spaceId;
  List<int> participantsIds;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.spaceId,
    required this.participantsIds,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    startDate: DateTime.parse(json['startDate']),
    endDate: DateTime.parse(json['endDate']),
    spaceId: json['spaceId'],
    participantsIds: List<int>.from(json['participantsIds']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'spaceId': spaceId,
    'participantsIds': participantsIds,
  };
}
