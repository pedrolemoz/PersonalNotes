import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user.dart';
import '../../infrastucture/datasources/users_remote_database.dart';
import '../../infrastucture/exceptions/user_exceptions.dart';
import '../mappers/user_mapper.dart';

class UsersRemoteDataBaseImplementation implements UsersRemoteDataBase {
  @override
  Future<void> storeUser(User user) async {
    try {
      await FirebaseFirestore.instance
          .collection('data')
          .doc(user.userID)
          .set(UserMapper.toMap(user));
    } catch (_) {
      throw UnableToStoreUserException();
    }
  }

  @override
  Future<bool> userHasData(User user) async {
    try {
      final userDataReference = await FirebaseFirestore.instance
          .collection('data')
          .doc(user.userID)
          .get();
      final userData = userDataReference.data();
      return userData != null;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<User> getUserById(String id) async {
    try {
      final userDataReference =
          await FirebaseFirestore.instance.collection('data').doc(id).get();
      final userData = userDataReference.data();
      return UserMapper.fromMap(userData!);
    } catch (_) {
      throw UnableToGetUserDataException();
    }
  }
}
