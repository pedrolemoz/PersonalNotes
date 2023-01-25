import '../../domain/entities/user.dart';

abstract class UsersRemoteDataBase {
  Future<void> storeUser(User user);

  Future<User> getUserById(String id);

  Future<bool> userHasData(User user);
}
