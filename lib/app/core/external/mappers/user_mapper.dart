import 'dart:convert';

import '../../domain/entities/user.dart';

class UserMapper {
  static Map<String, dynamic> toMap(User user) {
    return {
      'name': user.name,
      'email': user.email,
      'userID': user.userID,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      email: map['email'],
      userID: map['userID'],
    );
  }

  static String toJSON(User user) => json.encode(toMap(user));

  static User fromJSON(String source) => fromMap(json.decode(source));
}
