class BaseNode {
  int id;
  String title;
  String firstName;
  String lastName;
  DateTime birthDate;
  String gender;
  String address;
  String phone;
  List<String> interests;
  int userId;
  bool baseNode;

  BaseNode({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.phone,
    required this.interests,
    required this.userId,
    required this.baseNode,
  });

  factory BaseNode.fromJson(Map<String, dynamic> json) {
    return BaseNode(
      id: json['id'],
      title: json['title'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthDate: DateTime.parse(json['birthDate']),
      gender: json['gender'],
      address: json['address'],
      phone: json['phone'],
      interests: List<String>.from(json['interests']),
      userId: json['userId'],
      baseNode: json['baseNode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate.toIso8601String(),
      'gender': gender,
      'address': address,
      'phone': phone,
      'interests': interests,
      'userId': userId,
      'baseNode': baseNode,
    };
  }
}

class Account {
  String username;
  String email;
  BaseNode baseNode;

  Account({
    required this.username,
    required this.email,
    required this.baseNode,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      username: json['username'],
      email: json['email'],
      baseNode: BaseNode.fromJson(json['baseNode']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'baseNode': baseNode.toJson(),
    };
  }
}
