class Media {
  int id;
  String path;
  String type;
  int messageId;

  Media({
    required this.id,
    required this.path,
    required this.type,
    required this.messageId,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    id: json['id'],
    path: json['path'],
    type: json['type'],
    messageId: json['messageId'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'path': path,
    'type': type,
    'messageId': messageId,
  };
}
