import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/user.dart';
import '../../../../core/domain/failures/failure.dart';
import '../../../../core/infrastucture/datasources/users_local_database.dart';
import '../../../../core/infrastucture/datasources/users_remote_database.dart';
import '../../domain/failures/authentication_failures.dart';
import '../../domain/inputs/login_with_credentials_input.dart';
import '../../domain/inputs/register_with_credentials_input.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../datasources/authentication_service.dart';
import '../datasources/google_auth_service.dart';
import '../exceptions/exceptions.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  final AuthenticationService _authService;
  final GoogleAuthService _googleAuthService;
  final UsersRemoteDataBase _remoteDataBase;
  final UsersLocalDataBase _localDatabase;

  const AuthenticationRepositoryImplementation(
    this._authService,
    this._googleAuthService,
    this._remoteDataBase,
    this._localDatabase,
  );

  @override
  Future<Either<Failure, User>> registerWithCredentials(
    RegisterWithCredentialsInput input,
  ) async {
    try {
      final user = await _authService.registerWithCredentials(input);
      await _remoteDataBase.storeUser(user);
      await _localDatabase.storeUser(user);
      return Right(user);
    } on InvalidUserCredentialsException {
      return Left(InvalidUserCredentialsFailure());
    } catch (_) {
      return Left(UnableToRegisterUserFailure());
    }
  }

  @override
  Future<Either<Failure, User>> loginWithCredentials(
    LoginWithCredentialsInput input,
  ) async {
    try {
      final user = await _authService.loginWithCredentials(input);
      await _localDatabase.storeUser(user);
      return Right(user);
    } on InvalidUserCredentialsException {
      return Left(InvalidUserCredentialsFailure());
    } on UserNotFoundException {
      return Left(UserNotFoundFailure());
    } catch (_) {
      return Left(UnableToAuthenticateUserFailure());
    }
  }

  @override
  Future<Either<Failure, User>> authWithGoogle() async {
    try {
      var user = await _googleAuthService.authWithGoogle();
      if (await _remoteDataBase.userHasData(user)) {
        user = await _remoteDataBase.getUserById(user.userID);
      } else {
        await _remoteDataBase.storeUser(user);
      }
      await _localDatabase.storeUser(user);
      return Right(user);
    } catch (_) {
      return Left(UnableToAuthenticateUserFailure());
    }
  }
}
