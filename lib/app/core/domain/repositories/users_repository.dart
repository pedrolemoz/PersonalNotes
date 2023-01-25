import 'package:dartz/dartz.dart';

import '../enums/auth_state.dart';
import '../failures/failure.dart';

abstract class UsersRepository {
  Future<Either<Failure, AuthState>> getAuthState();
}
