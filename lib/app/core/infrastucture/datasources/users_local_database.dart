import '../../domain/entities/user.dart';

abstract class UsersLocalDataBase {
  Future<void> storeUser(User user);

  Future<User> getUser();

  Future<bool> userHasData();
}
