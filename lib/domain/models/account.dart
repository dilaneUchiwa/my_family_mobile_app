import 'package:my_family_mobile_app/domain/models/node.dart';

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
      // username: json['username'],
      // email: json['email'],
      email: "dilane@gmail.com",
      username: 'dilane',
      // baseNode: BaseNode. fromJson(json['baseNode']),
      baseNode: BaseNode(
        id: 5,
       title: "Famille pierre.",
      firstName: "Michael",
      lastName: "Smith",
      birthDate: DateTime(1990, 1, 1),
      gender: "Male",
      address: "123 Main St",
      phone: "555-1234",
      interests: ["reading", "sports"],
      userId: 1,
      baseNode: true,
      ),
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