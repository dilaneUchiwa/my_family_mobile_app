class SpaceNode {
  int id;
  String userId;
  String pseudo;

  SpaceNode({
    required this.id,
    required this.userId,
    required this.pseudo,
  });

  factory SpaceNode.fromJson(Map<String, dynamic> json) {
    return SpaceNode(
      id: json['id'],
      userId: json['userId'],
      pseudo: json['pseudo'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'pseudo': pseudo,
  };
}
