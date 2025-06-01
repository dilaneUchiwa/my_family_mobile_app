
class User {
  String? id;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  List<String> roles;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.roles,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      roles: List<String>.from(json['roles']),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'roles': roles,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

String userToString(User user) {
  return '''
    User {
        id: ${user.id ?? "N/A"},
        firstName: ${user.firstName},
        lastName: ${user.lastName},
        phoneNumber: ${user.phoneNumber},
        email: ${user.email},
        roles: ${user.roles},
        createdAt: ${user.createdAt ?? "N/A"},
        updatedAt: ${user.updatedAt ?? "N/A"}
    }
  ''';
}

class Account {
  String? id;
  User owner;
  bool? isActive;
  bool? confirmed;
  String userName;
  String? password;

  Account({
    this.id,
    required this.owner,
    this.isActive,
    this.confirmed,
    required this.userName,
  });

  set setPassword(String password){
    this.password = password;
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      owner: User.fromJson(json['owner']),
      isActive: json['isActive'],
      confirmed: json['confirmed'],
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner': owner.toJson(),
      'isActive': isActive,
      'confirmed': confirmed,
      'userName': userName,
      'password': password,
    };
  }
}