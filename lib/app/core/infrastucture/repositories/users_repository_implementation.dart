import 'package:dartz/dartz.dart';

import '../../domain/enums/auth_state.dart';
import '../../domain/failures/failure.dart';
import '../../domain/failures/user_failures.dart';
import '../../domain/repositories/users_repository.dart';
import '../datasources/users_local_database.dart';

class UsersRepositoryImplementation implements UsersRepository {
  final UsersLocalDataBase _usersLocalDatabase;

  const UsersRepositoryImplementation(this._usersLocalDatabase);

  @override
  Future<Either<Failure, AuthState>> getAuthState() async {
    try {
      final userHasData = await _usersLocalDatabase.userHasData();
      final authState =
          userHasData ? AuthState.authenticated : AuthState.notAuthenticated;
      return Right(authState);
    } catch (_) {
      return Left(UnableToGetUserAuthStateFailure());
    }
  }
}
