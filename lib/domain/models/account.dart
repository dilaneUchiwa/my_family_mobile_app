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
      username: json['username'],
      email: json['email'],
      // baseNode: BaseNode. fromJson(json['baseNode']),
      baseNode: BaseNode(
        id: 1,
        title: 'Mr',
        firstName: 'John',
        lastName: 'Doe',
        birthDate: DateTime(1990, 5, 15),
        gender: 'Male',
        address: '123 Main Street, Paris',
        phone: '+33 6 12 34 56 78',
        interests: ['Reading', 'Traveling', 'Coding'],
        userId: 42,
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