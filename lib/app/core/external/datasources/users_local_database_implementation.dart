import 'dart:convert';

import 'package:hive/hive.dart';

import '../../domain/entities/user.dart';
import '../../infrastucture/datasources/users_local_database.dart';
import '../../infrastucture/exceptions/user_exceptions.dart';
import '../../utils/cache_keys.dart';
import '../mappers/user_mapper.dart';

class UsersLocalDataBaseImplementation implements UsersLocalDataBase {
  @override
  Future<void> storeUser(User user) async {
    try {
      final box = await Hive.openBox(CacheKeys.appCache);
      await box.put(CacheKeys.userData, UserMapper.toJSON(user));
    } catch (_) {
      throw UnableToStoreUserException();
    }
  }

  @override
  Future<bool> userHasData() async {
    try {
      final box = await Hive.openBox(CacheKeys.appCache);
      return box.containsKey(CacheKeys.userData);
    } catch (_) {
      return false;
    }
  }

  @override
  Future<User> getUser() async {
    try {
      final box = await Hive.openBox(CacheKeys.appCache);
      final userData = json.decode(await box.get(CacheKeys.userData));
      return UserMapper.fromMap(userData);
    } catch (_) {
      throw UnableToGetUserDataException();
    }
  }
}
