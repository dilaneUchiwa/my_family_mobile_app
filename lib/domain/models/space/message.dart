import 'package:my_family_mobile_app/domain/models/space/media.dart';

class Message {
  int id;
  String content;
  DateTime sendDate;
  int senderId;
  String senderName;
  int discussionId;
  int? replyToId;
  List<Media> medias;
  bool read;
  DateTime? readDate;

  Message({
    required this.id,
    required this.content,
    required this.sendDate,
    required this.senderId,
    required this.senderName,
    required this.discussionId,
    this.replyToId,
    required this.medias,
    required this.read,
    this.readDate,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json['id'],
    content: json['content'],
    sendDate: DateTime.parse(json['sendDate']),
    senderId: json['senderId'],
    senderName: json['senderName'],
    discussionId: json['discussionId'],
    replyToId: json['replyToId'],
    medias: (json['medias'] as List).map((m) => Media.fromJson(m)).toList(),
    read: json['read'],
    readDate: json['readDate'] != null ? DateTime.parse(json['readDate']) : null,
  );
}
