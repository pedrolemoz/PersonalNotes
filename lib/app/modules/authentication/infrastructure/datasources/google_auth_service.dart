import '../../../../core/domain/entities/user.dart';

abstract class GoogleAuthService {
  Future<User> authWithGoogle();
}
